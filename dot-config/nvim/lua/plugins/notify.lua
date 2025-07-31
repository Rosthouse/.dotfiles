return {
	"rcarriga/nvim-notify",
	opts = {
		timeout = 5000,
	},
	config = function()
		vim.notify = require("notify")
	end,
}
