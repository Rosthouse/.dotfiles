
vim.pack.add({
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
})

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fh", function()
  telescope.find_files({ hidden = true, no_ignore = true })
end, { desc = "Telescope find hidden files" })

vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "find buffers" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "find buffers" })
vim.keymap.set("n", "<leader>ft", telescope.commands, { desc = "find commands" })
vim.keymap.set("n", "<leader>fd", telescope.diagnostics, { desc = "find diagnostics" })

vim.keymap.set("n", "<leader>fq", telescope.quickfix, { desc = "quickfix list" })
vim.keymap.set("n", "<leader>fj", telescope.jumplist, { desc = "jump list" })

