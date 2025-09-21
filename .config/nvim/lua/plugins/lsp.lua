return {
	{
		"neovim/nvim-lspconfig",
		version = "*",
		event = { "VeryLazy", "BufReadPre" },
		config = require("utils").load("conf/lsp"),
	},
	{
		"williamboman/mason.nvim",
		version = "*",
	},
	{
		"williamboman/mason-lspconfig.nvim",
		version = "*",
	},
	{
		"folke/neodev.nvim",
		version = "*",
	},
	{
		"nvimdev/lspsaga.nvim",
		version = "*",
	},
	{
		"b0o/schemastore.nvim",
		version = "*",
	},
}
