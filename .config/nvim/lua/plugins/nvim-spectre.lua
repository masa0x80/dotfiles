return {
	"nvim-pack/nvim-spectre",
	version = "*",
	event = "VeryLazy",
	highlight = {
		ui = "String",
		search = "DiffChange",
		replace = "DiffAdd",
	},
	mapping = {
		["run_replace"] = {
			map = "<leader><C-r>",
			cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
			desc = "replace all",
		},
	},
}
