return {
	"anuvyklack/fold-preview.nvim",
	event = "VeryLazy",
	config = require("config.utils").load("conf/fold-preview"),
	dependencies = {
		"anuvyklack/pretty-fold.nvim",
	},
}
