vim.keymap.set(
	{ "n", "v" },
	"gx",
	"<Plug>(openbrowser-smart-search)",
	{ noremap = true, silent = true, desc = "Open browser" }
)
