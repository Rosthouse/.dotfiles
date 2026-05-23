vim.pack.add({
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  }
})

require('nvim-treesitter').install({
  'bash',
  'c_sharp',
  'html',
  'lua',
  'python',
  'razor',
})
