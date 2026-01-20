return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    "tpope/vim-dadbod",
    { "kristijanhusak/vim-dadbod-completion", lazy = true },
  },
  cmd = {
    "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer"
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_win_position = 'left'
    vim.g.db_ui_winwidth = 30

    require("which-key").add({
      { "<leader>ls", group = " SQL" },
    })

    vim.api.nvim_set_keymap("n", "<leader>lst", "<cmd>DBUIToggle<cr>", { desc = "Toggle UI", noremap = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "sql",
      callback = function()
        vim.bo.completefunc = "vim_dadbod_completion#omni"
        vim.keymap.set("i", "<C-space>", vim.bo.complete, { desc = "trigger autocompletion" })
      end,
    })
  end,
}
