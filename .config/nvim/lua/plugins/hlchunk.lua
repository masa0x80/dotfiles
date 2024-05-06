return {
	"shellRaining/hlchunk.nvim",
	event = { "BufNewFile", "BufRead" },
	config = require("config.utils").load("conf/hlchunk"),
}
