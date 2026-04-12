return {
	{
		"lambdalisue/kensaku-search.vim",
		version = "*",
		event = "VeryLazy",
		config = function()
			local map = require("utils").map
			map("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>", { desc = "(kensaku-search-repace)" })
		end,
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
