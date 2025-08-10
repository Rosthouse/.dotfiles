vim.api.nvim_set_keymap("n", "<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Open Diagnostics" })
vim.api.nvim_set_keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
-- The following command requires plug-ins "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", and optionally "kyazdani42/nvim-web-devicons" for icon support
vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })
