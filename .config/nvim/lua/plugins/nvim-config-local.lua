return {
	"klen/nvim-config-local",
	event = "VeryLazy",
	config = require("config.utils").load("conf/nvim-config-local"),
}
