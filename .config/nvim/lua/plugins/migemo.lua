return {
	"delphinus/luamigemo",
	version = "*",
	init = function()
		local map = require("utils").map
		-- `/` `?` 検索の確定時にローマ字を migemo の正規表現に置き換える
		map("c", "<CR>", function()
			local cmdtype = vim.fn.getcmdtype()
			if cmdtype == "/" or cmdtype == "?" then
				return [[<C-\>ev:lua.require'plugins.conf.migemo'.replace_cmdline()<CR><CR>]]
			end
			return "<CR>"
		end, { expr = true, desc = "Migemo search" })
	end,
}
