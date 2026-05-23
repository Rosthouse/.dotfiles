
vim.pack.add({
  { src = 'https://www.github.com/nvim-neotest/neotest', version = 'master' },
  { src = 'https://www.github.com/nvim-neotest/nvim-nio', version = 'master' },
  { src = 'https://www.github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://www.github.com/nsidorenco/neotest-vstest', version = 'main' },
})

require('neotest').setup({
  adapters = {
    require('neotest-vstest'),
  }
})
