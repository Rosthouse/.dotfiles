vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("", "<leader>Y", '"+Y', { desc = "Yank to clipboard" })

vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste after cursor from clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before cursor from clipboard" })
