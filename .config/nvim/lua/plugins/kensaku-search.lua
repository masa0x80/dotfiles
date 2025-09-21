return {
	{
		"lambdalisue/kensaku-search.vim",
		version = "*",
		event = "VeryLazy",
		config = require("utils").load("conf/kensaku-search"),
	},
	{
		"lambdalisue/kensaku.vim",
		version = "*",
		event = "VeryLazy",
	},
	{
		"vim-denops/denops.vim",
		version = "*",
		event = "VeryLazy",
	},
}
