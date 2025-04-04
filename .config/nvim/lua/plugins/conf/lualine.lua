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
			return not vim.tbl_contains(vim.tbl_keys(require("config.utils").hidden_formatters), f)
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

require("lualine").setup({
	sections = {
		lualine_c = filename,
		lualine_x = { selectionCount, lsp_names },
		lualine_y = { "encoding", "fileformat", "filetype" },
		lualine_z = { "location", "progress" },
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
