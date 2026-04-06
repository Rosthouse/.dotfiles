vim.pack.add({
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/igorlfs/nvim-dap-view',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
})

local dap = require('dap')
local dap_vtext = require('nvim-dap-virtual-text')
local dap_view = require('dap-view')

dap_vtext.setup({})

local function start_debugging()
  dap_view.open()
  dap.continue()
end

vim.api.nvim_set_keymap('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = ' Toggle Breakpoint', noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ds', start_debugging, { desc = ' Continue', noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dt', function() dap.terminate() end, { desc = ' Terminate', noremap = true })
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
