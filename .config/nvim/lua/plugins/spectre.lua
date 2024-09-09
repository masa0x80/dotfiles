return {
	{
		"windwp/nvim-spectre",
		opts = {
			default = {
				find = {
					options = { "hidden" },
				},
			},
		},
		event = "VeryLazy",
		config = require("config.utils").load("conf/spectre"),
	},
	{
		"nvim-lua/plenary.nvim",
	},
}
