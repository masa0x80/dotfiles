return {
	"NeogitOrg/neogit",
	cmd = { "Neogit" },
	keys = {
		{ ",gg", "<Cmd>Neogit<CR>" },
		{ ",gc", "<Cmd>Neogit commit<CR>" },
		{ ",GG", "<Cmd>DiffviewOpen<CR>" },
		{ ",GC", "<Cmd>DiffviewOpen<CR>" },
		{ ",cc", "<Cmd>DiffviewClose<CR>" },
	},
	config = require("config.utils").load("conf/neogit"),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
}
