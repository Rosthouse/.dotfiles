return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("nvim-tree").setup({})
    -- KeyMaps
    vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { desc = " Focus tree", silent = true, noremap = true })
    vim.keymap.set("n", "<leader>E", ":NvimTreeClose<CR>", { desc = "󰅘 Close tree", silent = true, noremap = true })
  end,
}
