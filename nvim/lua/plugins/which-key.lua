return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>-",
			function()
				local wk = require("which-key")
				wk.show({ global = false })
				wk.add({
					{ "<leader>f", group = "Find" },
					{ "<leader>d", group = "Diagnostics" },
					{
						"<leader>b",
						group = "Buffers",
						expand = function()
							return require("which-key.extras").expand.buf()
						end,
					},
				})
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
