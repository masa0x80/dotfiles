return {
	{
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
		},
		config = require("config.utils").load("conf/neo-tree"),
		init = require("config.utils").load("init/neo-tree"),
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"MunifTanjim/nui.nvim",
	},
	{
		"kyazdani42/nvim-web-devicons",
	},
	{
		"joshdick/onedark.vim",
	},
	{
		"antosha417/nvim-lsp-file-operations",
		config = require("config.utils").load("conf/nvim-lsp-file-operations"),
	},
}
