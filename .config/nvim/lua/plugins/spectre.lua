return {
	"windwp/nvim-spectre",
	opts = {
		default = {
			find = {
				options = { "hidden" },
			},
		},
	},
	event = "VeryLazy",
	config = require("config.utils").load("conf/spectre"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
