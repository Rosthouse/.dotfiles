vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
})

require("mason").setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
})
require("mason-lspconfig").setup({
    -- A list of servers to ensure are installed.
    -- These will be installed automatically by mason-lspconfig.
    -- Alternatively, you can leave this empty and install manually
    -- or use the ensure_installed function.
    ensure_installed = { 
      'bashls',
      "lua_ls", 
      "pyright", 
    },
    -- You can also pass settings to mason.nvim's setup function here
    -- if you want to customize mason from mason-lspconfig
})

vim.lsp.config("*", {
  -- capabilities = capabilities,
  root_markers = { ".git" },
})

vim.lsp.config('lua_ls', {
  --@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', },
      diagnostics = { globals = { "vim" } } },
  },
})

vim.lsp.config("pyright", {
  settings = {
    venvPath = ".venv",
    venv = "venv",
  }
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("bashls")

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
--     client.server_capabilities.semanticTokensProvider = nil
-- 
--     local builtin = require("telescope.builtin")
--     vim.keymap.set("n", "<leader>flr", builtin.lsp_references, { desc = "References" })
--     vim.keymap.set("n", "<leader>fli", builtin.lsp_incoming_calls, { desc = "Incoming Calls" })
--     vim.keymap.set("n", "<leader>flo", builtin.lsp_outgoing_calls, { desc = "LSP Outgoing Calls" })
--     vim.keymap.set("n", "<leader>fld", function()
--       require("telescope.builtin").diagnostics({ bufnr = 0 })
--     end, { desc = "Document Diagnostics" })
-- 
--     vim.keymap.set("n", "<leader>flD", builtin.diagnostics, { desc = "Workspace Diagnostics" })
--   end
-- })


-- {
--   {
--     "folke/lazydev.nvim",
--     ft = "lua"
--     opts = {
--       library = { path = "${3rd}/luv/library", words = { "vim%.uv" } }
--     },
--   },
--   {
--     "seblyng/roslyn.nvim",
--     ---@module 'roslyn.config'
--     ---@type RoslynNvimConfig
--     opts = {
--         -- your configuration comes here; leave empty for default settings
--     },
--   },
--   {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--       {
--         "mason-org/mason.nvim",
--       },
--     },
--     config = function()
--       require("mason").setup({
--         registries = {
--           "github:mason-org/mason-registry",
--           "github:Crashdummyy/mason-registry",
--         },
--       })
-- 
--       vim.lsp.config("roslyn", {
--           on_attach = function()
--               print("This will run when the server attaches!")
--           end,
--           settings = {
--               ["csharp|inlay_hints"] = {
--                   csharp_enable_inlay_hints_for_implicit_object_creation = true,
--                   csharp_enable_inlay_hints_for_implicit_variable_types = true,
--               },
--               ["csharp|code_lens"] = {
--                   dotnet_enable_references_code_lens = true,
--               },
--           },
--       })
-- 
--   },
-- }
