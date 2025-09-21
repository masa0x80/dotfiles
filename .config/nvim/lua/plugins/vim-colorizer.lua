return {
	"norcalli/nvim-colorizer.lua",
	version = "*",
	event = { "BufNewFile", "BufReadPre" },
	config = require("utils").load("conf/nvim-colorizer"),
}
