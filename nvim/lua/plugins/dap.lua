return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mason-org/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			require("nvim-dap-virtual-text").setup({})

			-- Setup Mason integration
			require("mason-nvim-dap").setup({
				ensure_installed = { "netcoredbg" },
				automatic_installation = true,
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
				coreclr = {
					type = "executable",
					command = vim.fn.exepath("netcoredbg"),
					args = { "--interpreter=vscode" },
				},
			})

			-- Setup Keymaps
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🛑", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = "▶️", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
			)

			--breakpoint icons
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🛑", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = "▶️", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
			)

			--toggle breakpoint
			vim.api.nvim_set_keymap("n", "<F9>", ":DapToggleBreakpoint<CR>", { noremap = true })

			-- start debugging
			vim.api.nvim_set_keymap("n", "<F5>", ":DapContinue<CR>", { noremap = true })

			--reset layout
			vim.api.nvim_set_keymap(
				"n",
				"<leader>dr",
				"<cmd>lua require('dapui').open({reset = true})<CR>",
				{ noremap = true }
			)

			local dapui = require("dapui")
			dapui.setup()

			--auto open & close the UI panes
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
