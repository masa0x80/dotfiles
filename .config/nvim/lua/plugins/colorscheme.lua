return {
	"navarasu/onedark.nvim",
	opts = {
		style = "warmer",
		code_stye = {
			comments = "none",
		},
	},
	config = require("config.utils").load("conf/colorscheme"),

	-- ref. https://github.com/folke/lazy.nvim?tab=readme-ov-file#-colorschemes
	lazy = false,
	priority = 1000,
}
