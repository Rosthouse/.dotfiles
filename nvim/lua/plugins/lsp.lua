return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim" },
			{ "mason-org/mason-lspconfig.nvim" },
			{ "saghen/blink.cmp" },
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({ automatic_enable = false })
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.omnisharp.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })
		end,
	},
}
