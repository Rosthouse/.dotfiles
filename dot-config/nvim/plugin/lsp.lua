vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
})

require('mason').setup({
  registries = {
    'github:mason-org/mason-registry',
  },
})

require('mason-lspconfig').setup({
    ensure_installed = {
      'bashls',
      'csharp_ls',
      'lua_ls',
      'pyright',
    },
})

vim.lsp.config('*', {
  -- capabilities = capabilities,
  root_markers = { '.git' },
})
