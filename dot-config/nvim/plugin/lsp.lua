vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
})

-- require('mason').setup({
--   registries = {
--     'github:mason-org/mason-registry',
--   },
-- })
-- 
-- require('mason-lspconfig').setup({
--     ensure_installed = {
--       'bashls',
--       'lua_ls',
--       'pyright',
--     },
-- })
-- 
-- vim.lsp.config('*', {
--   -- capabilities = capabilities,
--   root_markers = { '.git' },
-- })
-- 
-- vim.lsp.config('roslyn_ls', {
--     filetypes = { 'cs', 'razor' },
-- })
-- vim.lsp.enable('roslyn_ls')
