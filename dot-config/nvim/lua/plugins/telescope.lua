return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope find buffers" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope find buffers" })
			vim.keymap.set("n", "<leader>ft", builtin.commands, { desc = "Telescope find commands" })
		end,
	},
	{
		"EthanJWright/vs-tasks.nvim",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local telescope = require("telescope")

			vim.keymap.set("n", "<leader>ta", telescope.extensions.vstask.tasks, { desc = "List Tasks" })
			--vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.inputs()<CR>
			--vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.jobs()<CR>
			--vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.clear_inputs()<CR>
			--vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.cleanup_completed_jobs()<CR>
			--vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.launch()<cr>
			--vim.keymap.set('n', '<leader>ta', telescope.extensions.vstask.command()<cr>
		end,
	},
}
