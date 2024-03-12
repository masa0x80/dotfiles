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
	local ft = vim.api.nvim_eval("&filetype")
	local linters = require("lint").linters_by_ft[ft]
	for _, linter in ipairs(linters ~= nil and linters or {}) do
		table.insert(clients, linter)
	end
	local filetype = require("conform").formatters_by_ft[ft]
	for _, formatter in ipairs(filetype or {}) do
		if type(formatter) == "table" then
			table.insert(clients, "{" .. table.concat(formatter, ",") .. "}")
		else
			table.insert(clients, formatter)
		end
	end
	return #clients == 0 and "" or " " .. table.concat(clients, ", ")
end

require("lualine").setup({
	sections = {
		lualine_c = filename,
		lualine_x = { lsp_names },
		lualine_y = { "encoding", "fileformat", "filetype" },
		lualine_z = { "location", "progress" },
	},
	tabline = {
		lualine_a = {
			{
				"buffers",
				use_mode_colors = true,
			},
		},
		lualine_z = {
			{
				"tabs",
				use_mode_colors = true,
			},
		},
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

local c = require("config.color")
local icon_colors = {
	File = c.blue,
	Module = c.dark_yellow,
	Namespace = c.red,
	Package = c.yellow,
	Class = c.yellow,
	Method = c.blue,
	Property = c.cyan,
	Field = c.purple,
	Constructor = c.blue,
	Enum = c.purple,
	Interface = c.green,
	Function = c.blue,
	Variable = c.purple,
	Constant = c.dark_yellow,
	String = c.green,
	Number = c.dark_yellow,
	Boolean = c.dark_yellow,
	Array = c.yellow,
	Object = c.red,
	Key = c.cyan,
	Null = c.fg,
	EnumMember = c.yellow,
	Struct = c.purple,
	Event = c.yellow,
	Operator = c.red,
	TypeParameter = c.red,
}
local set_hl = vim.api.nvim_set_hl
for kind, color in pairs(icon_colors) do
	set_hl(0, "NavicIcons" .. kind, { fg = color })
end
set_hl(0, "NavicText", { fg = c.fg })
set_hl(0, "NavicSeparator", { fg = c.cyan })
