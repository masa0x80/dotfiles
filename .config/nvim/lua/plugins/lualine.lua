return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = require("config.utils").load("conf/lualine"),
	},
	{
		"SmiteshP/nvim-navic",
		config = require("config.utils").load("conf/navic"),
	},
}
