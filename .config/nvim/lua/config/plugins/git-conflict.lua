require("git-conflict").setup({
	highlights = { -- They must have background color, otherwise the default color will be used
		incoming = "NormalFloat",
		current = "NormalFloat",
	},
})

local color = require("config.color")
local set_hl = vim.api.nvim_set_hl
set_hl(0, "GitConflictCurrentLabel", { fg = color.Black, bg = color.Green })
set_hl(0, "GitConflictIncomingLabel", { fg = color.Black, bg = color.Blue })
set_hl(0, "GitConflictAncestorLabel", { fg = color.Black, bg = color.Grey })
