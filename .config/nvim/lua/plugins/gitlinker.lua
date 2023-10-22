return {
	"ruifm/gitlinker.nvim",
	event = "VeryLazy",
	config = require("config.utils").load("conf/gitlinker"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
