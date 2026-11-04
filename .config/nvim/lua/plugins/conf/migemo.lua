-- luamigemo でローマ字を日本語にもマッチする正規表現に変換する
local M = {}

local function get()
	local ok, luamigemo = pcall(require, "luamigemo")
	if not ok then
		return nil
	end
	return luamigemo
end

---@param word string
---@param style? "vim"|"pcre" 既定は "pcre" (ripgrep 用)
---@return string 変換に失敗した場合は word をそのまま返す
M.query = function(word, style)
	local luamigemo = get()
	if not luamigemo or word == "" then
		return word
	end
	local rxop = style == "vim" and luamigemo.RXOP_VIM or luamigemo.RXOP_PCRE
	local ok, regex = pcall(luamigemo.query, word, rxop)
	return ok and regex ~= "" and regex or word
end

-- `/` `?` 検索のコマンドラインを migemo の正規表現に置き換える
-- `\` を含む場合は Vim の正規表現を書いているとみなして変換しない
M.replace_cmdline = function()
	local line = vim.fn.getcmdline()
	local cmdtype = vim.fn.getcmdtype()
	if (cmdtype ~= "/" and cmdtype ~= "?") or line == "" or line:find("\\", 1, true) then
		return line
	end
	local regex = M.query(line, "vim")
	if regex == line then
		return line
	end
	-- 検索の区切り文字がパターンの終端と解釈されないようにエスケープする
	return "\\m" .. regex:gsub(vim.pesc(cmdtype), "\\" .. cmdtype)
end

return M
