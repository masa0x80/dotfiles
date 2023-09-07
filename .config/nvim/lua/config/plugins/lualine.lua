require("lsp-status").config({
	status_symbol = "",
	diagnostics = false,
})
require("lualine").setup({
	sections = {
		lualine_c = {
			"navic",
			color_correction = nil,
			navic_opts = nil,
		},
		lualine_y = { "require('lsp-status').status()" },
	},
})
