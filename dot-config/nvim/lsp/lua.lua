vim.lsp.config('lua_ls', {
  --@type lspconfig.settings.lua_ls
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim', 'require' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      }
    },
  },
})
vim.lsp.enable("lua_ls")
