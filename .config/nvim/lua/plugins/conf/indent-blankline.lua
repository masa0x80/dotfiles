local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local c = require("config.color")
local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = c.red })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = c.yellow })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = c.blue })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = c.orange })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = c.green })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = c.purple })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = c.cyan })
end)

require("ibl").setup({
	indent = {
		char = "┊",
		highlight = highlight,
	},
})
