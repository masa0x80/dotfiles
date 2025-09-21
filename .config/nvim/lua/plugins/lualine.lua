return {
	{
		"nvim-lualine/lualine.nvim",
		version = "*",
		event = "VeryLazy",
		config = require("utils").load("conf/lualine"),
	},
	{
		"SmiteshP/nvim-navic",
		version = "*",
		config = require("utils").load("conf/navic"),
	},
}
