return {
	"nvim-mini/mini.files",
	version = "*",
	event = "VeryLazy",
	config = require("utils").load("conf/mini_files"),
}
