return {
	"norcalli/nvim-colorizer.lua",
	version = "*",
	event = { "BufNewFile", "BufReadPre" },
	config = require("config.utils").load("conf/nvim-colorizer"),
}
