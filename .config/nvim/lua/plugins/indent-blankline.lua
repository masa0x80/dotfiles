return {
	"lukas-reineke/indent-blankline.nvim",
	config = require("config.utils").load("conf/indent-blankline"),
	event = { "BufNewFile", "BufRead" },
}
