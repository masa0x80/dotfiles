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

require("lsp-status").config({
	status_symbol = "",
	diagnostics = false,
})
require("lualine").setup({
	sections = {
		lualine_c = filename,
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "require('lsp-status').status()" },
		lualine_z = { "location", "progress" },
	},
	tabline = {
		lualine_a = { "buffers" },
		lualine_z = { "tabs" },
	},
	winbar = {
		lualine_c = {
			{
				"navic",
				color_correction = "static",
				navic_opts = {
					highlight = true,
				},
			},
		},
		lualine_z = { "filename" },
	},
	inactive_winbar = {
		lualine_c = {
			{
				"navic",
				color_correction = "static",
				navic_opts = {
					highlight = true,
				},
			},
		},
		lualine_z = { "filename" },
	},
})

local color = require("config.color")
local icon_colors = {
	File = color.Blue,
	Module = color.DarkYellow,
	Namespace = color.Red,
	Package = color.Yellow,
	Class = color.Yellow,
	Method = color.Blue,
	Property = color.Cyan,
	Field = color.Magenta,
	Constructor = color.Blue,
	Enum = color.Magenta,
	Interface = color.Green,
	Function = color.Blue,
	Variable = color.Magenta,
	Constant = color.DarkYellow,
	String = color.Green,
	Number = color.DarkYellow,
	Boolean = color.DarkYellow,
	Array = color.Yellow,
	Object = color.Red,
	Key = color.Cyan,
	Null = color.White,
	EnumMember = color.Yellow,
	Struct = color.Magenta,
	Event = color.Yellow,
	Operator = color.Red,
	TypeParameter = color.Red,
}
local set_hl = vim.api.nvim_set_hl
for kind, c in pairs(icon_colors) do
	set_hl(0, "NavicIcons" .. kind, { fg = c })
end
set_hl(0, "NavicText", { fg = color.White })
set_hl(0, "NavicSeparator", { fg = color.Cyan })
