return {
	{
		"neovim/nvim-lspconfig",
		event = { "VeryLazy", "BufReadPre" },
		config = require("config.utils").load("conf/lsp"),
	},
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"folke/neodev.nvim",
	},
	{
		"nvimdev/lspsaga.nvim",
	},
	{
		"b0o/schemastore.nvim",
	},
	{
		"lewis6991/hover.nvim",
	},
}
