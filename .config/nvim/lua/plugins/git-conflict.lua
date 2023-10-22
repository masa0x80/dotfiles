return {
	"akinsho/git-conflict.nvim",
	opts = {
		highlights = { -- They must have background color, otherwise the default color will be used
			incoming = "NormalFloat",
			current = "NormalFloat",
		},
	},
	event = { "BufNewFile", "BufRead" },
	init = require("config.utils").load("init/git-conflict"),
}
