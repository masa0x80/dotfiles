return {
	{
		"folke/noice.nvim",
		version = "*",
		event = "VeryLazy",
		config = require("config.utils").load("conf/noice"),
	},
	{
		"rcarriga/nvim-notify",
		version = "*",
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
}
