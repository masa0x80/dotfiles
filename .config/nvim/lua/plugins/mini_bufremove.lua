return {
	"nvim-mini/mini.bufremove",
	version = "*",
	event = "VeryLazy",
	config = require("utils").load("conf/mini_bufremove"),
}
