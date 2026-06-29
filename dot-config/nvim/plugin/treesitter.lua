vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'avsc', 'csharp', 'json', },
  callback = function()
    vim.treesitter.start()
  end,
})


vim.treesitter.language.add('json',
  { path = '/opt/treesitter/tree-sitter-json/libtree-sitter-json.so' }
)

vim.treesitter.language.register('csharp', { 'cs', 'razor' })
vim.treesitter.language.register('json', { 'avcl' })
