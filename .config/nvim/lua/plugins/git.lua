return {
	{
		"dinhhuy258/git.nvim",
		event = "VeryLazy",
		config = require("config.utils").load("conf/git"),
	},
	{
		"akinsho/git-conflict.nvim",
		opts = {
			highlights = { -- They must have background color, otherwise the default color will be used
				incoming = "NormalFloat",
				current = "NormalFloat",
			},
		},
		event = { "BufNewFile", "BufRead" },
		init = require("config.utils").load("init/git-conflict"),
	},
	{
		"rhysd/git-messenger.vim",
		keys = {
			{ "<C-g><C-l>", desc = "Show Git Log" },
		},
		config = require("config.utils").load("conf/git-messenger"),
		init = require("config.utils").load("init/git-messenger"),
	},
	{
		"ruifm/gitlinker.nvim",
		event = "VeryLazy",
		config = require("config.utils").load("conf/gitlinker"),
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufNewFile", "BufRead" },
		config = require("config.utils").load("conf/gitsigns"),
	},
}
