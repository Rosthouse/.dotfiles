vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("", "<leader>Y", '"+Y', { desc = "Yank to clipboard" })

vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste after cursor from clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before cursor from clipboard" })

-- Mini files functions
vim.keymap.set('n', '<leader>e', function() require('mini.files').open() end, { desc = 'Opens mini.files', })

-- LSP keymaps
vim.keymap.set('n', '<C-a>', function() vim.lsp.buf.code_action() end, { desc = 'Show avaiable code actions' })
