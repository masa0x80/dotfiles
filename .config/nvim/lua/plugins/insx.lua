return {
	"hrsh7th/nvim-insx",
	version = "*",
	event = "InsertEnter",
	config = require("config.utils").load("conf/insx"),
}
