return {
	"stevearc/conform.nvim",
	version = "*",
	event = "VeryLazy",
	config = require("config.utils").load("conf/conform"),
}
