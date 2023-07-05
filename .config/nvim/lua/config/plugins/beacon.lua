local color = require("config.plugins.color.custom")
local set_hl = vim.api.nvim_set_hl
set_hl(0, "Beacon", { fg = color.Black, bg = color.White })

require("beacon").setup({
	size = 64,
	minimal_jump = 3,
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "n", "n:Beacon<CR>", opts)
keymap("n", "N", "N:Beacon<CR>", opts)
keymap("n", "*", "*:Beacon<CR>", opts)
keymap("n", "#", "#:Beacon<CR>", opts)
