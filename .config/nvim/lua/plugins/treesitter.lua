return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = "*",
		event = "VeryLazy",
		build = ":TSUpdate",
		config = require("utils").load("conf/treesitter"),
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		version = "*",
	},
	{
		"windwp/nvim-ts-autotag",
		version = "*",
	},
	{
		"David-Kunz/treesitter-unit",
		version = "*",
		keys = {
			{ "iu", ':lua require"treesitter-unit".select()<CR>', noremap = true, mode = "x" },
			{ "au", ':lua require"treesitter-unit".select(true)<CR>', noremap = true, mode = "x" },
			{ "iu", ':<C-u>lua require"treesitter-unit".select()<CR>', noremap = true, mode = "o" },
			{ "au", ':<C-u>lua require"treesitter-unit".select(true)<CR>', noremap = true, mode = "o" },
		},
	},
	{
		"kiyoon/treesitter-indent-object.nvim",
		version = "*",
		keys = {
			{
				"ai",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>",
				mode = { "x", "o" },
				desc = "Select context-aware indent (outer)",
			},
			{
				"aI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>",
				mode = { "x", "o" },
				desc = "Select context-aware indent (outer, line-wise)",
			},
			{
				"ii",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>",
				mode = { "x", "o" },
				desc = "Select context-aware indent (inner, partial range)",
			},
			{
				"iI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>",
				mode = { "x", "o" },
				desc = "Select context-aware indent (inner, entire range)",
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		version = "*",
		event = { "CursorHold", "CursorMoved", "ModeChanged" },
		config = require("utils").load("conf/Comment"),
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		version = "*",
	},
}
