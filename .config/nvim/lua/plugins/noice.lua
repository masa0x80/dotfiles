return {
	"folke/noice.nvim",
	event = "VeryLazy",
	config = require("config.utils").load("conf/noice"),
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			keys = {
				{
					"<leader>un",
					function()
						require("notify").dismiss({ silent = true, pending = true })
					end,
					desc = "Dismiss all Notifications",
				},
			},
			opts = {
				timeout = 10000,
			},
		},
	},
}
