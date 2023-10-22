return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = require("config.utils").load("conf/lualine"),
	dependencies = {
		"kyazdani42/nvim-web-devicons",
		"SmiteshP/nvim-navic",
	},
}
