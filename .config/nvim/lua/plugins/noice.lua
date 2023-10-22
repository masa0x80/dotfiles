return {
	"folke/noice.nvim",
	event = "VeryLazy",
	config = require("config.utils").load("conf/noice"),
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}
