return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<Leader>k", "<Cmd>Telescope kensaku<CR>", desc = "Search by [K]ensaku" },

			{
				"<Leader>E",
				"<Cmd>lua require('telescope._extensions.ghq_builtin').list()<CR>",
				desc = "Telescope ghq list",
			},
		},
		cmd = { "Telescope" },
		config = require("config.utils").load("conf/telescope"),
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-telescope/telescope-ghq.nvim",
	},
	{
		"nvim-telescope/telescope-dap.nvim",
	},
	{
		"Allianaab2m/telescope-kensaku.nvim",
	},
}
