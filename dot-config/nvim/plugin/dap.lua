vim.pack.add({
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/igorlfs/nvim-dap-view',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
})

local dap = require('dap')
local dap_vtext = require('nvim-dap-virtual-text')
local dap_view = require('dap-view')

dap_view.setup({
  winbar = {
    sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
  }
})

dap_vtext.setup({})

-- Adapter for .NET (CoreCLR) debugging via netcoredbg.
-- nvim-dap launches this binary and speaks the Debug Adapter Protocol to it
-- over stdio (that is what `--interpreter=vscode` selects).
-- `coreclr` is the `type` used by .NET launch configs (matches .vscode/launch.json).
dap.adapters.coreclr = {
  type = 'executable',
  command = 'netcoredbg', -- must be on $PATH (installed at ~/.local/bin/netcoredbg)
  args = { '--interpreter=vscode' },
}

-- No configurations are defined here on purpose: nvim-dap reads a project's
-- `.vscode/launch.json` automatically when you call `dap.continue()` (the
-- built-in "dap.launch.json" config provider). `${workspaceFolder}` resolves
-- to nvim's cwd, and `${input:...}` pickString prompts are supported, so the
-- existing DEV launch configs work as-is when nvim is opened at the solution root.

-- launch.json configs are matched by filetype, and nvim-dap assumes the
-- config `type` is the filetype. Map `coreclr` configs to `cs` buffers,
-- otherwise dap.continue() never offers them.
require('dap.ext.vscode').type_to_filetypes.coreclr = { 'cs' }

-- Fallback for projects without .vscode/launch.json: prompt for the dll.
dap.configurations.cs = {
  {
    type = 'coreclr',
    name = 'Launch dll',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

-- Open/close dap-view with the session, regardless of how it was started.
dap.listeners.before.attach['dap-view'] = function() dap_view.open() end
dap.listeners.before.launch['dap-view'] = function() dap_view.open() end
dap.listeners.before.event_terminated['dap-view'] = function() dap_view.close() end
dap.listeners.before.event_exited['dap-view'] = function() dap_view.close() end

vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end,
  { desc = ' Toggle Breakpoint', noremap = true })
vim.keymap.set('n', '<leader>ds', function() dap.continue() end, { desc = ' Continue', noremap = true })
vim.keymap.set('n', '<leader>dt', function() dap.terminate() end, { desc = ' Terminate', noremap = true })
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)


vim.fn.sign_define(
  'DapBreakpoint',
  { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' }
)
vim.fn.sign_define(
  'DapStopped',
  { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' }
)

-- Setup Keymaps
