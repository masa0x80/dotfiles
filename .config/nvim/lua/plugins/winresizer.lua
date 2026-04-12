return {
	"simeji/winresizer",
	version = "*",
	keys = {
		{ "<C-g><C-r>", nil, desc = "WinResizer" },
	},
	init = function()
		vim.g.winresizer_start_key = "<C-g><C-r>"
	end,
}
