vim.pack.add({
  'https://github.com/tpope/vim-dadbod',
  'https://github.com/kristijanhusak/vim-dadbod-ui',
  'https://github.com/kristijanhusak/vim-dadbod-completion',
})

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_win_position = 'left'
vim.g.db_ui_winwidth = 30

vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>DBUIToggle<cr>", { desc = "Toggle UI", noremap = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function(ev)
    -- vim-dadbod-completion exposes an omnifunc; point this buffer's omnifunc at it
    vim.bo[ev.buf].omnifunc = "vim_dadbod_completion#omni"
    -- mini.completion uses `completefunc` for LSP and falls back to this when a
    -- buffer has no LSP (SQL buffers don't). Make that fallback trigger the
    -- omnifunc above so table/column completion shows automatically as you type.
    vim.b[ev.buf].minicompletion_config = { fallback_action = "<C-x><C-o>" }
  end,
})
