local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

local local_lua_dir = vim.fn.expand("$HOME/.config.local/nvim/lua/")
local base_lua_dir = vim.fn.stdpath("config") .. "/lua/"

-- $HOME/.config.local/nvim/lua/plugins/ 配下のプラグインを読み込み
local local_plugins = {}
for _, file in ipairs(vim.fn.glob(local_lua_dir .. "plugins/*.lua", false, true)) do
	local name = vim.fn.fnamemodify(file, ":t")
	local_plugins[name] = file
end

local specs = {}

-- 読み込みに失敗したら通知する
local function load_spec(file)
	local ok, spec = pcall(dofile, file)
	if not ok then
		vim.notify(("Failed to load plugin spec: %s\n%s"):format(file, spec), vim.log.levels.ERROR)
		return
	end
	if spec then
		table.insert(specs, spec)
	end
end

-- $HOME/.config.local/nvim/lua/plugins/ 配下にファイルがあればそちらを優先する
for _, file in ipairs(vim.fn.glob(base_lua_dir .. "plugins/*.lua", false, true)) do
	local name = vim.fn.fnamemodify(file, ":t")
	load_spec(local_plugins[name] or file)
	local_plugins[name] = nil
end

-- $HOME/.config.local/nvim/lua/plugins/ 配下だけにあるプラグインを追加
for _, file in pairs(local_plugins) do
	load_spec(file)
end

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
