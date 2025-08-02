return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "ConformInfo" },
		config = function()
			local conform = require("conform")
			conform.setup({
				default_format_opts = {
					lsp_format = "prefer",
				},
				formatters = {
					prettier = {
						options = {
							ft_parsers = {
								json = "json",
								jsonc = "json",
							},
						},
					},
					csharpier = {
						command = "csharpier",
						args = { "format" },
						stdin = true,
					},
				},
				formatters_by_ft = {
					lua = { "stylua" },
					c_sharp = { "csharpier" },
					cs = { "csharpier" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettierd", "prettier", stop_after_first = true },
					jsonc = { "prettierd", "prettier", stop_after_first = true },
					python = { "ruff" },
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					conform.format({ bufnr = args.buf })
				end,
			})

			vim.keymap.set("n", "<leader>fmt", conform.formatexpr, { desc = "Format file" })
		end,
	},
}
