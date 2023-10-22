return {
	"petertriho/nvim-scrollbar",
	event = { "BufNewFile", "BufRead" },
	config = require("config.utils").load("conf/nvim-scrollbar"),
	dependencies = {
		"rapan931/lasterisk.nvim",
		"kevinhwang91/nvim-hlslens",
	},
}
