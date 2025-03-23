return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	config = require("config.utils").load("conf/bufferline"),
}
