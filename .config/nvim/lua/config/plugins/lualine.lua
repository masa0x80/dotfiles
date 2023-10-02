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

local lsp_names = function()
	local clients = {}
	for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
		table.insert(clients, client.name)
	end
	local filetype = require("guard.filetype")[vim.api.nvim_eval("&filetype")]
	for _, client in ipairs(filetype ~= nil and filetype.formatter or {}) do
		local cmd = client.cmd
		if cmd ~= "cat" then
			table.insert(clients, cmd)
		end
	end
	return #clients == 0 and "" or "  " .. table.concat(clients, ", ")
end

require("lualine").setup({
	sections = {
		lualine_c = filename,
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { lsp_names },
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
	File = color.BLUE,
	Module = color.DARK_YELLOW,
	Namespace = color.RED,
	Package = color.YELLOW,
	Class = color.YELLOW,
	Method = color.BLUE,
	Property = color.CYAN,
	Field = color.MAGENTA,
	Constructor = color.BLUE,
	Enum = color.MAGENTA,
	Interface = color.GREEN,
	Function = color.BLUE,
	Variable = color.MAGENTA,
	Constant = color.DARK_YELLOW,
	String = color.GREEN,
	Number = color.DARK_YELLOW,
	Boolean = color.DARK_YELLOW,
	Array = color.YELLOW,
	Object = color.RED,
	Key = color.CYAN,
	Null = color.WHITE,
	EnumMember = color.YELLOW,
	Struct = color.MAGENTA,
	Event = color.YELLOW,
	Operator = color.RED,
	TypeParameter = color.RED,
}
local set_hl = vim.api.nvim_set_hl
for kind, c in pairs(icon_colors) do
	set_hl(0, "NavicIcons" .. kind, { fg = c })
end
set_hl(0, "NavicText", { fg = color.WHITE })
set_hl(0, "NavicSeparator", { fg = color.CYAN })
