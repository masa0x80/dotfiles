local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: $HOME/.config/nvim/lua/plugins/ 配下にファイルがあればそちらを優先する
local local_lua_dir = vim.fn.expand("$HOME/.config.local/nvim/lua/")
local base_lua_dir = vim.fn.stdpath("config") .. "/lua/"
local local_only_specs = {}
for _, file in ipairs(vim.fn.glob(local_lua_dir .. "plugins/*.lua", false, true)) do
	local relpath = file:sub(#local_lua_dir + 1) -- remove base path and .lua extension
	local modname = relpath:gsub("%.lua$", ""):gsub("/", ".")
	package.preload[modname] = function()
		return dofile(file)
	end
	-- ベースに存在しないもは直接追加
	if vim.fn.filereadable(base_lua_dir .. relpath) == 0 then
		local ok, spec = pcall(dofile, file)
		if ok and spec then
			table.insert(local_only_specs, spec)
		end
	end
end

local specs = { { import = "plugins" } }
vim.list_extend(specs, local_only_specs)
require("lazy").setup(specs, {
	defaults = {
		lazy = true,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"netrwPlugin",
				"tohtml",
				"tutor",
			},
		},
	},
})
