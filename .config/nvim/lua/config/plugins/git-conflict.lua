require("git-conflict").setup({
	highlights = { -- They must have background color, otherwise the default color will be used
		incoming = "NormalFloat",
		current = "NormalFloat",
	},
})

local color = require("config.color")
local set_hl = vim.api.nvim_set_hl
set_hl(0, "GitConflictCurrentLabel", { fg = color.BLACK, bg = color.GREEN })
set_hl(0, "GitConflictIncomingLabel", { fg = color.BLACK, bg = color.BLUE })
set_hl(0, "GitConflictAncestorLabel", { fg = color.BLACK, bg = color.WHITE })
