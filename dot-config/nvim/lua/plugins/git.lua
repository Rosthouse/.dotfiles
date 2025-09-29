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
      local ng = require("neogit")
      vim.keymap.set('n', '<leader>Gb', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Blame' })
      vim.keymap.set('n', '<leader>Gc', ng.open, { desc = 'Open' })
      vim.keymap.set('n', '<leader>Gm', function()
        ng.open({ 'merge' })
      end, { desc = 'Merge' })
      vim.keymap.set('n', '<leader>Gp', function()
        ng.open({ 'push' })
      end, { desc = 'Push' })
      vim.keymap.set('n', '<leader>GP', function()
        ng.open({ 'pull' })
      end, { desc = 'Pull' })
    end,
  }
})
