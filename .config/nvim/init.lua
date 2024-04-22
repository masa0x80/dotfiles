require("config")
require("misc")

local load_if_exists = function(path)
	local p = string.format(vim.fn.expand("$HOME") .. "/.config.local/nvim/lua/%s", path)
	if vim.fn.filereadable(p) == 1 then
		vim.fn.execute("luafile " .. p)
	end
end
load_if_exists("config/local.lua")
load_if_exists("misc/local.lua")
