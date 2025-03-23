return {
	"klen/nvim-config-local",
	version = "*",
	lazy = false,
	config = require("config.utils").load("conf/nvim-config-local"),
}
