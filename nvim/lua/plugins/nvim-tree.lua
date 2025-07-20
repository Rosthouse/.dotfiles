return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		require("nvim-tree").setup({})
		-- KeyMaps
		vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { silent = true, noremap = true })
		vim.keymap.set("n", "<leader>E", ":NvimTreeClose<CR>", { silent = true, noremap = true })
	end,
}
