local map = vim.keymap.set
map("n", "*", function()
	require("lasterisk").search()
	require("hlslens").start()
end)

map({ "n", "x" }, "g*", function()
	require("lasterisk").search({ is_whole = false, silent = true })
	require("hlslens").start()
end)

local c = require("config.color")
require("scrollbar").setup({
	handle = {
		color = c.black,
		hide_if_all_visible = false,
	},
	marks = {
		Search = { color = c.orange },
		Error = { color = c.red },
		Warn = { color = c.yellow },
		Info = { color = c.cyan },
		Hint = { color = c.purple },
		Misc = { color = c.purple },
	},
	excluded_filetypes = {
		"",
		"cmp_docs",
		"cmp_menu",
		"noice",
		"prompt",
		"TelescopePrompt",
	},
	handlers = {
		search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
	},
})
