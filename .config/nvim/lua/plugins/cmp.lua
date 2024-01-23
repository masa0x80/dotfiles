local u = require("config.utils")
return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	config = u.load("conf/cmp"),
	dependencies = {
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"f3fora/cmp-spell",
		"zbirenbaum/copilot-cmp",
	},
}
