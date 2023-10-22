return {
	"mfussenegger/nvim-lint",
	event = "BufReadPre",
	config = require("config.utils").load("conf/nvim-lint"),
}
