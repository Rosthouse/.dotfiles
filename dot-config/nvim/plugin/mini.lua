vim.pack.add({
	'https://github.com/nvim-mini/mini.nvim',
})

require('mini.basics').setup({
})

require('mini.completion').setup({
  window = {
    signature = { border = 'rounded'},
  },
})

-- Files
local files = require('mini.files')
files.setup()
vim.keymap.set('n', '<leader>e', function() files.open(vim.api.nvim_buf_get_name(0)) end, { desc = 'Opens mini.files', })
vim.keymap.set('n', '<leader>E', function() files.open() end, { desc = 'Opens mini.files', })

-- General
require('mini.icons').setup()
require('mini.notify').setup()
