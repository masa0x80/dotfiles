return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		keys = {
			{ "<Leader>k", "<Cmd>Telescope kensaku<CR>", desc = "Search by [K]ensaku" },

			{
				"<Leader>E",
				"<Cmd>lua require('telescope._extensions.ghq_builtin').list()<CR>",
				desc = "Telescope ghq list",
			},
		},
		cmd = { "Telescope" },
		config = require("utils").load("conf/telescope"),
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		version = "*",
		build = "make",
	},
	{
		"nvim-telescope/telescope-ghq.nvim",
		version = "*",
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		version = "*",
	},
	{
		"Allianaab2m/telescope-kensaku.nvim",
		version = "*",
	},
}
