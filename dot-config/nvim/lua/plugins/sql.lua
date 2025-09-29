return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
  },
  cmd = {
    "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer"
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    require("which-key").add({
      { "<leader>ls", group = " SQL" },
    })
    vim.api.nvim_set_keymap("n", "<leader>lst", "<cmd>DBUIToggle<cr>", { desc = "Toggle UI", noremap = true })
  end,
}
