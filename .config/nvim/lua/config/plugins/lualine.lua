local tabline = require("tabline")
tabline.setup()

require("lsp-status").config({
	status_symbol = "",
	diagnostics = false,
})
local filename = {
	{
		"filename",

		-- 0: Just the filename
		-- 1: Relative path
		-- 2: Absolute path
		-- 3: Absolute path, with tilde as the home directory
		path = 1,
	},
}
require("lualine").setup({
	sections = {
		lualine_c = {},
		lualine_y = { "require('lsp-status').status()" },
	},
	inactive_sections = {
		lualine_c = filename,
	},
	tabline = {
		lualine_a = { 'vim.fn.substitute(vim.fn.expand("%"), vim.fn.expand("$PWD") .. "/", "", "")' },
		lualine_x = { tabline.tabline_tabs },
	},
})
