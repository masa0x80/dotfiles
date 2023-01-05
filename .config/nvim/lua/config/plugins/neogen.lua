require("neogen").setup({})

vim.keymap.set(
	"n",
	"<Leader>a",
	require("neogen").generate,
	{ noremap = true, silent = true, desc = "Generate an annotation" }
)
