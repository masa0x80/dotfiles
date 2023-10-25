local neogit = require("neogit")
neogit.setup({
	kind = "replace",
})

local color = require("config.color")
local set_hl = vim.api.nvim_set_hl
set_hl(0, "NeogitCursorLine", { fg = color.NONE })
set_hl(0, "NeogitDiffAdd", { fg = color.BLACK, bg = color.GREEN })
set_hl(0, "NeogitDiffAddHighlight", { fg = color.GREEN, bg = color.CURSOR_GREY })
set_hl(0, "NeogitDiffDelete", { fg = color.BLACK, bg = color.RED })
set_hl(0, "NeogitDiffDeleteHighlight", { fg = color.RED, bg = color.CURSOR_GREY })

vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "NeogitPushComplete",
	group = "_",
	callback = neogit.close,
})
