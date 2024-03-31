return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufNewFile", "BufRead" },
	config = require("config.utils").load("conf/nvim-colorizer"),
}
