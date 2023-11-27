return {
	"epwalsh/obsidian.nvim",
	version = "*",
	ft = "markdown",
	keys = {
		{ ";f", "<Cmd>ObsidianQuickSwitch<CR>", noremap = true, silent = true },
	},
	config = require("config.utils").load("conf/obsidian"),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
	},
}
