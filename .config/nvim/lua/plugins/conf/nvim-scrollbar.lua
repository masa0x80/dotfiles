vim.keymap.set("n", "*", function()
	require("lasterisk").search()
	require("hlslens").start()
end)

vim.keymap.set({ "n", "x" }, "g*", function()
	require("lasterisk").search({ is_whole = false, silent = true })
	require("hlslens").start()
end)

require("scrollbar").setup({
	handlers = {
		search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
	},
})

local set_hl = vim.api.nvim_set_hl
local color = require("config.color")
set_hl(0, "ScrollbarSearch", { fg = color.COMMENT_GREY })
set_hl(0, "ScrollbarSearchHandle", { fg = color.COMMENT_GREY, bg = "#2c323c" })
