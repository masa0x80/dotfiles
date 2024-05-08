return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufNewFile", "BufReadPre" },
	config = require("config.utils").load("conf/nvim-colorizer"),
}
