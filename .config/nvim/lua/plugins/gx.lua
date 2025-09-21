return {
	"chrishrb/gx.nvim",
	version = "*",
	keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
	cmd = { "Browse" },
	config = require("utils").load("conf/gx"),
}
