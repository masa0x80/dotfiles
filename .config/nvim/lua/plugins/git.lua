return {
	{
		"dinhhuy258/git.nvim",
		version = "*",
		event = "VeryLazy",
		config = require("config.utils").load("conf/git"),
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		opts = {
			highlights = { -- They must have background color, otherwise the default color will be used
				incoming = "NormalFloat",
				current = "NormalFloat",
			},
		},
		event = { "BufNewFile", "BufRead" },
	},
	{
		"rhysd/git-messenger.vim",
		version = "*",
		keys = {
			{ "<C-g><C-l>", desc = "Show Git Log" },
		},
		config = require("config.utils").load("conf/git-messenger"),
		init = require("config.utils").load("init/git-messenger"),
	},
	{
		"ruifm/gitlinker.nvim",
		version = "*",
		event = "VeryLazy",
		config = require("config.utils").load("conf/gitlinker"),
	},
	{
		"lewis6991/gitsigns.nvim",
		version = "*",
		event = { "BufNewFile", "BufRead" },
		config = require("config.utils").load("conf/gitsigns"),
	},
}
