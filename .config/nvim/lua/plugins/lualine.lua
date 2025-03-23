return {
	{
		"nvim-lualine/lualine.nvim",
		version = "*",
		event = "VeryLazy",
		config = require("config.utils").load("conf/lualine"),
	},
	{
		"SmiteshP/nvim-navic",
		version = "*",
		config = require("config.utils").load("conf/navic"),
	},
}
