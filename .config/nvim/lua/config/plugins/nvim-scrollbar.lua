vim.keymap.set("n", "*", function()
	require("lasterisk").search()
	require("hlslens").start()
end)

vim.keymap.set({ "n", "x" }, "g*", function()
	require("lasterisk").search({ is_whole = false })
	require("hlslens").start()
end)

require("scrollbar").setup({
	handlers = {
		search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
	},
})

require("config.plugins.colorscheme_custom")

local set_hl = vim.api.nvim_set_hl

-- nvim-scrollbar
set_hl(0, "ScrollbarSearch", { fg = CommentGrey })
set_hl(0, "ScrollbarSearchHandle", { fg = CommentGrey, bg = "#2c323c" })
