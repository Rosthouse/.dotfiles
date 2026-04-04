
vim.pack.add({
  'https://github.com/nvim-telescope/telescope.nvim'
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fh", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
end, { desc = "Telescope find hidden files" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "find buffers" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "find buffers" })
vim.keymap.set("n", "<leader>ft", builtin.commands, { desc = "find commands" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "find diagnostics" })

vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "quickfix list" })
vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "jump list" })

