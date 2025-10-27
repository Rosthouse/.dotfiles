return { {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  config = function()
    vim.keymap.set('n', '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = ' Window left' })
    vim.keymap.set('n', '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = ' Window right' })
    vim.keymap.set('n', '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = ' Window down' })
    vim.keymap.set('n', '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = ' Window up' })
  end,
},
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("nvim-tree").setup({
        update_focused_file = { enable = true },
      })
      -- KeyMaps
      vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { desc = " Focus tree", silent = true, noremap = true })
      vim.keymap.set("n", "<leader>E", ":NvimTreeClose<CR>", { desc = "󰅘 Close tree", silent = true, noremap = true })
    end,
  } }
