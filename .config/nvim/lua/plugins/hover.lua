return {
	"lewis6991/hover.nvim",
	version = "*",
	keys = {
		{
			"K",
			function()
				require("hover").open()
			end,
			desc = "hover.nvim (open)",
		},
	},
	config = function()
		require("hover").config({
			providers = {
				"hover.providers.lsp",
				"hover.providers.fold_preview",
				-- "hover.providers.gh",
				-- "hover.providers.gh_user",
				-- "hover.providers.jira",
				-- "hover.providers.dap",
				-- "hover.providers.man",
				-- "hover.providers.dictionary",
			},
			preview_opts = {
				border = "rounded",
			},
			preview_window = false,
		})
	end,
}
