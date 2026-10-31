-- kensaku.vim でローマ字の入力を日本語にもマッチする正規表現に変換して grep する
local M = {}

local function to_regex(search)
	local ok, regex = pcall(function()
		return vim.fn["kensaku#query"](search, { rxop = vim.fn.eval("g:kensaku#rxop#javascript") })
	end)
	return ok and regex ~= "" and regex or search
end

---@param opts? snacks.picker.grep.Config
M.grep = function(opts)
	Snacks.picker.grep(vim.tbl_deep_extend("force", {
		title = "Kensaku",
		hidden = true,
		ignored = true,
		exclude = { "*.age" },
		finder = function(finder_opts, ctx)
			local search = ctx.filter.search
			if search ~= "" then
				-- `foo -- -g *.md` のように `--` 以降は rg の引数なので変換しない
				local pattern, args = search:match("^(.-)(%s+%-%-%s.*)$")
				local c = ctx:clone()
				c.filter = setmetatable(
					{ search = to_regex(pattern or search) .. (args or "") },
					{ __index = ctx.filter }
				)
				ctx = c
			end
			return require("snacks.picker.source.grep").grep(finder_opts, ctx)
		end,
	}, opts or {}))
end

return M
