require("hover").setup({
	init = function()
		-- Require providers
		require("hover.providers.lsp")
		require("hover.providers.fold_preview")
		-- require('hover.providers.gh')
		-- require('hover.providers.gh_user')
		-- require('hover.providers.jira')
		-- require('hover.providers.dap')
		-- require('hover.providers.man')
		-- require('hover.providers.dictionary')
	end,
	preview_opts = {
		border = "single",
	},
	preview_window = false,
})
