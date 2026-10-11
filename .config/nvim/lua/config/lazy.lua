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

local plugin_dirs = {
	vim.fn.stdpath("config") .. "/lua/plugins/",
	vim.fn.expand("$HOME/.config.local/nvim/lua/plugins/"),
}

-- ファイル名 => パス。後に指定したディレクトリ（$HOME/.config.local/nvim/lua/plugins/）が同名ファイルを上書きする
local plugin_files = {}
for _, dir in ipairs(plugin_dirs) do
	for _, file in ipairs(vim.fn.glob(dir .. "*.lua", false, true)) do
		plugin_files[vim.fn.fnamemodify(file, ":t")] = file
	end
end

-- 読み込みに失敗したら通知する
local specs = {}
for _, file in vim.spairs(plugin_files) do
	local ok, spec = pcall(dofile, file)
	if not ok then
		vim.notify(("Failed to load plugin spec: %s\n%s"):format(file, spec), vim.log.levels.ERROR)
	elseif spec then
		table.insert(specs, spec)
	end
end

require("lazy").setup(specs, {
	defaults = {
		lazy = true,
	},
	rocks = {
		enabled = false,
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
