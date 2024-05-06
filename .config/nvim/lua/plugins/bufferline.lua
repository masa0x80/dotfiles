return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	config = require("config.utils").load("conf/bufferline"),
}
