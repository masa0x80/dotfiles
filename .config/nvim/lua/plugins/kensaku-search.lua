return {
	"lambdalisue/kensaku-search.vim",
	event = "VeryLazy",
	config = require("config.utils").load("conf/kensaku-search"),
	dependencies = {
		"lambdalisue/kensaku.vim",
		"vim-denops/denops.vim",
	},
}
