require("incline").setup()

vim.keymap.set(
	"n",
	"<Leader><C-g>",
	require("incline").toggle,
	{ noremap = true, silent = true, desc = "Toggle incline" }
)
