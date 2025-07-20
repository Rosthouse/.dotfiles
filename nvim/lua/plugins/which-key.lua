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
					{ "<leader>f", group = "file" },
					{
						"<leader>b",
						group = "buffers",
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
