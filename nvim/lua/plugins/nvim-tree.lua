return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },

  config = function()
    require("nvim-tree").setup {}

    vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "h", nvimtree.tree.close,        { desc = "Close" })
    vim.keymap.set("n", "H", nvimtree.tree.collapse_all, { desc = "Collapse All" })
  end,
}
