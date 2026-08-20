local keys = {}
for _, mod in ipairs({
	"plugins.conf.snacks.keys_find",
	"plugins.conf.snacks.keys_git",
	"plugins.conf.snacks.keys_grep",
	"plugins.conf.snacks.keys_search",
	"plugins.conf.snacks.keys_lsp",
	"plugins.conf.snacks.keys_misc",
}) do
	vim.list_extend(keys, require(mod))
end

return {
	"folke/snacks.nvim",
	version = "*",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		explorer = { enabled = true },
		gitbrowse = { enabled = true },
		image = require("plugins.conf.snacks.image"),
		indent = { enabled = false },
		input = { enabled = true },
		picker = require("plugins.conf.snacks.picker"),
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
		-- statuscol.nvim で設定しているのでSnacks側は無効化
		statuscolumn = { enabled = false },
		words = { enabled = true },
	},
	keys = keys,
}
