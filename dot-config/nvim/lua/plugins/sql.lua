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
    require("which-key").add({
      { "<leader>ls", group = " SQL" },
    })
    vim.api.nvim_set_keymap("n", "<leader>lst", "<cmd>DBUIToggle<cr>", { desc = "Toggle UI", noremap = true })
    vim.api.nvim_create_autocmd("FileType",{
      pattern = { "sql" },
      callback = function(ev)
        vim.lsp.omnifunc = require("vim-dadbod-completion").omni
      end,
    })

  end,
}
