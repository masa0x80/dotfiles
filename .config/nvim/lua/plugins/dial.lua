return {
	"monaqa/dial.nvim",
	keys = {
		{ "<C-a>", "<Plug>(dial-increment)", noremap = true },
		{ "<C-x>", "<Plug>(dial-decrement)", noremap = true },
		{ "g<C-a>", "g<Plug>(dial-increment)", noremap = true },
		{ "g<C-x>", "g<Plug>(dial-decrement)", noremap = true },
		{ "<C-a>", "<Plug>(dial-increment)", noremap = true, mode = "v" },
		{ "<C-x>", "<Plug>(dial-decrement)", noremap = true, mode = "v" },
		{ "g<C-a>", "g<Plug>(dial-increment)", noremap = true, mode = "v" },
		{ "g<C-x>", "g<Plug>(dial-decrement)", noremap = true, mode = "v" },
	},
	config = require("config.utils").load("conf/dial"),
}
