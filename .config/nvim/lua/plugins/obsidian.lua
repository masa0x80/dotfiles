return {
	"epwalsh/obsidian.nvim",
	version = "*",
	ft = "markdown",
	config = require("config.utils").load("conf/obsidian"),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
	},
}
