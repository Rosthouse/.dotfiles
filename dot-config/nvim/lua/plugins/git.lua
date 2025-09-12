return ({
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      vim.keymap.set('n', '<leader>Gb', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Blame' })
    end,
  }
})
