vim.pack.add({
  { src = 'https://www.github.com/nvim-neotest/neotest',      version = 'master' },
  { src = 'https://www.github.com/nvim-neotest/nvim-nio',     version = 'master' },
  { src = 'https://www.github.com/nsidorenco/neotest-vstest', version = 'main' },
})

local neotest = require('neotest');

neotest.setup({
  adapters = {
    require('neotest-vstest'),
  }
})

vim.keymap.set('n', '<leader>tt', neotest.summary.toggle)
vim.keymap.set('n', '<leader>tr', neotest.run.run)
vim.keymap.set('n', '<leader>tR', function() neotest.run.run(vim.fn.expand('%')) end)
vim.keymap.set('n', '<leader>tx', neotest.run.stop)
vim.keymap.set('n', '<leader>to', neotest.output.open)
