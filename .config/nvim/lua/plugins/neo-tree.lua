return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = { "Neotree" },
	keys = {
		{
			"-",
			"<Cmd>Neotree float reveal_force_cwd<CR>",
			noremap = true,
			silent = true,
			desc = "NeoTree float",
		},
		{
			"<Leader>st",
			"<Cmd>Neotree float git_status<CR>",
			noremap = true,
			silent = true,
			desc = "NeoTree git_status",
		},
		{
			"<Leader>E",
			"<Cmd>Neotree toggle left reveal_force_cwd<CR>",
			noremap = true,
			silent = true,
			desc = "NeoTreeFocusToggle",
		},
	},
	config = require("config.utils").load("conf/neo-tree"),
	init = require("config.utils").load("init/neo-tree"),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"kyazdani42/nvim-web-devicons",
		"joshdick/onedark.vim",
	},
}
