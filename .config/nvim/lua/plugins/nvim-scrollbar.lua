return {
	{
		"petertriho/nvim-scrollbar",
		version = "*",
		event = { "BufNewFile", "BufRead" },
		config = require("config.utils").load("conf/nvim-scrollbar"),
	},
	{
		"rapan931/lasterisk.nvim",
		version = "*",
	},
	{
		"kevinhwang91/nvim-hlslens",
		version = "*",
	},
}
