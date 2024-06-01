return {
	"neovim/nvim-lspconfig",
	event = { "VeryLazy", "BufReadPre" },
	config = require("config.utils").load("conf/lsp"),
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- Additional lua configuration, makes nvim stuff amazing
		"folke/neodev.nvim",

		"nvimdev/lspsaga.nvim",

		"b0o/schemastore.nvim",

		"lewis6991/hover.nvim",
	},
}
