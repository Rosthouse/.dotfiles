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
				debugpy = {},
			})

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🛑", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = "▶️", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
			)

			-- Setup Keymaps
			vim.api.nvim_set_keymap("n", "<F9>", ":DapToggleBreakpoint<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<F5>", ":DapContinue<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<F-17>", ":DapTerminate<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<F10>", ":DapStepOver<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<F11>", ":DapStepInto<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<F12>", ":DapStepOut<CR>", { noremap = true })
			vim.api.nvim_set_keymap(
				"n",
				"<leader>dr",
				"<cmd>lua require('dapui').toggle({reset = true})<CR>", --reset layout
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
		end,
	},
}
