return {
	"navarasu/onedark.nvim",
	opts = {
		style = "warmer",
		code_stye = {
			comments = "none",
		},
	},
	init = function()
		vim.cmd.colorscheme("onedark")
	end,
	config = require("config.utils").load("conf/color"),
}
