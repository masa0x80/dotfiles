return {
	"mfussenegger/nvim-lint",
	version = "*",
	event = "BufReadPre",
	config = require("config.utils").load("conf/nvim-lint"),
}
