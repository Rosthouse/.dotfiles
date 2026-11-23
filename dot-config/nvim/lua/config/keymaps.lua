-- map leader to <Space>
vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("", "<leader>Y", '"+Y', { desc = "Yank to clipboard" })

vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste after cursor from clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste before cursor from clipboard" })

vim.keymap.set("n", "<C-s>", function() vim.api.nvim_command("write") end, { desc = "Save current buffer" })
vim.keymap.set("n", "<C-S>", function() vim.api.nvim_command("wall") end, { desc = "Save all open buffers" })
-- Window management

-- Undotree
vim.keymap.set("n", "<leader>u", function() require("undotree").open() end, { desc = "Toggles the undotree" })
-- Mini files functions
vim.keymap.set("n", "<leader>e", function() require("mini.files").open() end, { desc = 'Opens mini.files', })
