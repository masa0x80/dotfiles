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
}
