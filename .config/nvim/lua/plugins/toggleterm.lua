return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{ "<C-\\>" },
		{
			"<Leader>tf",
			"<Cmd>TermFloat<CR>",
			noremap = true,
			silent = true,
			desc = "<v:count1>ToggleTerm direction=float",
		},
		{
			"<Leader>tb",
			"<Cmd>TermBottom<CR>",
			noremap = true,
			silent = true,
			desc = "<v:count1>ToggleTerm direction=horizontal",
		},
	},
	init = require("utils").load("init/toggleterm"),
	config = require("utils").load("conf/toggleterm"),
}
