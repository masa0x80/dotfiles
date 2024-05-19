require("hop").setup({
	uppercase_labels = true,
})

local map = vim.keymap.set
local opts = { remap = true }
local hop = require("hop")
local directions = require("hop.hint").HintDirection
map("", "<Leader><Space>", function()
	hop.hint_words({})
end, opts)
map("", "<Leader>k", function()
	hop.hint_words({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
end, opts)
map("", "<Leader>j", function()
	hop.hint_words({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
end, opts)
map("", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, opts)
map("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, opts)
map("", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, opts)
map("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, opts)
