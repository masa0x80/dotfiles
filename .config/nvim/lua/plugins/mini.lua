return {
	{
		"nvim-mini/mini.nvim",
		version = "*",
		lazy = false,
	},
	{
		"nvim-mini/mini.ai",
		version = "*",
		event = "VeryLazy",
		config = require("utils").load("conf/mini_ai"),
	},
	{
		"nvim-mini/mini.align",
		version = "*",
		event = "VeryLazy",
		opts = {
			mappings = {
				start = "<CR>",
			},
		},
	},
	{
		"nvim-mini/mini.bracketed",
		version = "*",
		event = "VeryLazy",
		config = require("utils").load("conf/mini_bracketed"),
	},
	{
		"nvim-mini/mini.bufremove",
		version = "*",
		event = "VeryLazy",
		config = require("utils").load("conf/mini_bufremove"),
	},
	{
		"nvim-mini/mini.cursorword",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-mini/mini.files",
		version = "*",
		event = "VeryLazy",
		config = require("utils").load("conf/mini_files"),
	},
	{
		"nvim-mini/mini.indentscope",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-mini/mini.misc",
		version = "*",
		lazy = false,
		config = require("utils").load("conf/mini_misc"),
	},
	{
		"nvim-mini/mini.move",
		version = "*",
		event = "VeryLazy",
		opts = {
			mappings = {
				left = "H",
				right = "L",
				down = "J",
				up = "K",

				line_left = "",
				line_right = "",
				line_down = "<C-g><C-j>",
				line_up = "<C-g><C-k>",
			},
			options = {
				reindent_linewise = false,
			},
		},
	},
	{
		"nvim-mini/mini.operators",
		version = "*",
		event = "VeryLazy",
		config = require("utils").load("conf/mini_operators"),
	},
	{
		"nvim-mini/mini.splitjoin",
		version = "*",
		event = "VeryLazy",
		config = require("utils").load("conf/mini_splitjoin"),
	},
}
