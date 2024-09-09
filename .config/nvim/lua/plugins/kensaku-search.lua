return {
	{
		"lambdalisue/kensaku-search.vim",
		event = "VeryLazy",
		config = require("config.utils").load("conf/kensaku-search"),
	},
	{
		event = "VeryLazy",
		"lambdalisue/kensaku.vim",
	},
	{
		event = "VeryLazy",
		"vim-denops/denops.vim",
	},
}
