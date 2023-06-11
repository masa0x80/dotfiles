require("incline").setup({
	window = {
		margin = { horizontal = 0, vertical = 0 },
	},
})

vim.keymap.set(
	"n",
	"<Leader><C-g>",
	require("incline").toggle,
	{ noremap = true, silent = true, desc = "Toggle incline" }
)
