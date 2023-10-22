return {
	"lewis6991/gitsigns.nvim",
	event = { "BufNewFile", "BufRead" },
	config = require("config.utils").load("conf/gitsigns"),
}
