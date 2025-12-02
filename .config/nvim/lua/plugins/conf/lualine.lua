local filename = {
	"filename",

	-- 0: Just the filename
	-- 1: Relative path
	-- 2: Absolute path
	-- 3: Absolute path, with tilde as the home directory
	path = 1,
}

local lsp_names = function()
	local clients = {}
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		table.insert(clients, client.name)
	end
	local ft = vim.api.nvim_eval("&filetype")
	local linters = require("lint").linters_by_ft[ft]
	for _, linter in ipairs(linters ~= nil and linters or {}) do
		table.insert(clients, linter)
	end
	local filetype = require("conform").formatters_by_ft[ft]
	for _, formatter in
		ipairs(vim.tbl_filter(function(f)
			return not vim.tbl_contains(vim.tbl_keys(require("utils").hidden_formatters), f)
		end, filetype or {}))
	do
		table.insert(clients, formatter)
	end
	return #clients == 0 and "" or " " .. table.concat(clients, ", ")
end

-- ref. 【Neovim】lualineの表示をカスタムしてみる。Visualモードで選択された行数、文字数を表示してみる https://zenn.dev/glaucus03/articles/ff710d27de4e55
local function selectionCount()
	local mode = vim.fn.mode()

	-- 選択モードでない場合には無効
	if not (mode:find("[vV\22]") ~= nil) then
		return ""
	end

	local line1 = vim.fn.line("v")
	local line2 = vim.fn.line(".")
	local pos1 = vim.fn.col("v")
	local pos2 = vim.fn.col(".")

	if line1 == line2 and pos1 > pos2 then
		local tmp = pos1
		pos1 = pos2
		pos2 = tmp
	elseif line1 > line2 then
		local tmp = line1
		line1 = line2
		line2 = tmp
		tmp = pos1
		pos1 = pos2
		pos2 = tmp
	end

	if mode == "V" then
		-- 行選択モードの場合は、各行全体をカウントする
		pos1 = 1
		pos2 = vim.fn.strlen(vim.fn.getline(line2)) + 1
	end

	local lines = vim.fn.getline(line1, line2)

	local n = vim.fn.len(lines)
	if mode == "V" then
		lines[1] = lines[1]:sub(1, vim.fn.len(lines[1]))
		lines[n] = lines[n]:sub(1, vim.fn.len(lines[n]))
	else
		if n == 1 then
			lines = { lines[1]:sub(pos1, pos2) }
		else
			lines[1] = lines[1]:sub(pos1, vim.fn.len(lines[1]))
			lines[n] = lines[n]:sub(1, pos2)
		end
	end

	local str = vim.fn.join(lines, "")
	local chars = vim.fn.strchars(str)
	return tostring(n) .. " lines, " .. tostring(chars) .. " characters"
end

local colors = require("everforest.colours").generate_palette(
	vim.tbl_extend("keep", { transparent_background_level = 2 }, require("everforest.init").default_config),
	vim.o.background
)
local theme = {
	normal = {
		a = { bg = colors.green, fg = colors.bg0, gui = "bold" },
		b = { bg = colors.bg3, fg = colors.fg },
		c = { bg = colors.none, fg = colors.fg },
		x = { bg = colors.none, fg = colors.fg },
		y = { bg = colors.bg3, fg = colors.fg },
		z = { bg = colors.green, fg = colors.bg0 },
	},
	insert = {
		a = { bg = colors.fg, fg = colors.bg0, gui = "bold" },
		b = { bg = colors.bg3, fg = colors.fg },
		c = { bg = colors.none, fg = colors.fg },
	},
	visual = {
		a = { bg = colors.red, fg = colors.bg0, gui = "bold" },
		b = { bg = colors.bg3, fg = colors.fg },
		c = { bg = colors.none, fg = colors.fg },
	},
	replace = {
		a = { bg = colors.orange, fg = colors.bg0, gui = "bold" },
		b = { bg = colors.bg3, fg = colors.fg },
		c = { bg = colors.bg1, fg = colors.fg },
	},
	command = {
		a = { bg = colors.aqua, fg = colors.bg0, gui = "bold" },
		b = { bg = colors.bg3, fg = colors.fg },
		c = { bg = colors.bg1, fg = colors.fg },
	},
	terminal = {
		a = { bg = colors.purple, fg = colors.bg0, gui = "bold" },
		b = { bg = colors.bg3, fg = colors.fg },
		c = { bg = colors.bg1, fg = colors.fg },
	},
	inactive = {
		a = { bg = colors.bg1, fg = colors.grey1, gui = "bold" },
		b = { bg = colors.bg1, fg = colors.grey1 },
		c = { bg = colors.bg1, fg = colors.grey1 },
	},
}

local color = require("lualine.themes.everforest")
require("lualine").setup({
	options = {
		theme = theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		always_show_tabline = false,
	},
	sections = {
		lualine_a = { { "mode", separator = { left = "", right = "" } } },
		lualine_b = { filename, "diff", "diagnostics" },
		lualine_c = { lsp_names },
		lualine_x = { selectionCount },
		lualine_y = { "encoding", "fileformat", "filetype" },
		lualine_z = { "location", { "progress", separator = { left = "", right = "" } } },
	},
	tabline = {
		lualine_b = { filename },
		lualine_c = {
			{
				"navic",
				color_correction = "static",
				navic_opts = {
					highlight = true,
				},
			},
		},
		lualine_z = {
			{
				"tabs",
				separator = { left = "", right = "" },
				cond = function()
					return #vim.fn.gettabinfo() > 1
				end,
			},
		},
	},
	winbar = {
		lualine_a = { { "filename", separator = { left = "", right = "" } } },
		lualine_c = {
			{
				"navic",
				color_correction = "static",
				navic_opts = {
					highlight = true,
				},
				cond = function()
					return #vim.fn.gettabinfo() == 1
				end,
			},
		},
	},
	inactive_winbar = {
		lualine_a = { { "filename", separator = { left = "", right = "" } } },
	},
})
