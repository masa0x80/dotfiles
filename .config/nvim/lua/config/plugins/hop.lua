local status_ok, p = pcall(require, "hop")
if not status_ok then
	return
end
p.setup()

local opts = {}
vim.keymap.set("", "<Leader>h", "<Cmd>HopChar2<CR>", opts)
vim.keymap.set("", "<Leader>w", "<Cmd>HopWord<CR>", opts)
vim.keymap.set("", "<Leader>l", "<Cmd>HopLine<CR>", opts)
vim.keymap.set("", "f", "<Cmd>HopChar1<CR>", opts)
vim.keymap.set("", "F", "<Cmd>HopChar1BC<CR>", opts)

local directions = require("hop.hint").HintDirection
vim.keymap.set("", "t", function()
	p.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
end, { remap = true })
vim.keymap.set("", "T", function()
	p.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
end, { remap = true })
