require("eyeliner").setup({
	highlight_on_key = false,
})

local c = require("config.color")
vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = c.fg, bg = c.bg_d, bold = true })
vim.api.nvim_set_hl(0, "EyelinerSecondary", { reverse = true, bold = true, italic = true })
