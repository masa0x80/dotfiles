local map = vim.keymap.set
map("n", "*", function()
	require("lasterisk").search()
	require("hlslens").start()
end)

map({ "n", "x" }, "g*", function()
	require("lasterisk").search({ is_whole = false, silent = true })
	require("hlslens").start()
end)

require("scrollbar").setup({
	hide_if_all_visible = true,
	marks = {
		Search = {
			highlight = "Orange",
		},
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
