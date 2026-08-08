vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim"
})

require("gitsigns").setup({
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')
    vim.keymap.set('n', '<leader>gb', function() gitsigns.blame_line({ full = true }) end, { desc = 'Git Blame', })
    vim.keymap.set('n', '<leader>gbt', gitsigns.toggle_current_line_blame, { desc = 'Git Blame', })
  end
})

-- Octo.nvim for PR review
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/pwntester/octo.nvim"
})

require("octo").setup()
