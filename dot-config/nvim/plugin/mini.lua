vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable' },
})

require('mini.basics').setup()
require('mini.icons').setup()
require('mini.snippets').setup()
require('mini.notify').setup()
require('mini.surround').setup()

require('mini.completion').setup({
  window = {
    signature = { border = 'rounded' },
  },
})

-- status
require('mini.statusline').setup()

-- Files
local files = require('mini.files')
files.setup()
vim.keymap.set('n', '<leader>e', function() files.open(vim.api.nvim_buf_get_name(0)) end, { desc = 'Opens mini.files', })
vim.keymap.set('n', '<leader>E', function() files.open() end, { desc = 'Opens mini.files', })
