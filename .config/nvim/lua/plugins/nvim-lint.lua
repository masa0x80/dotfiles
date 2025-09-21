return {
	"mfussenegger/nvim-lint",
	version = "*",
	event = "BufReadPre",
	config = require("utils").load("conf/nvim-lint"),
}
