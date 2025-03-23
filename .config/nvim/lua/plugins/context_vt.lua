return {
	"haringsrob/nvim_context_vt",
	version = "*",
	event = { "BufNewFile", "BufRead" },
	opts = {
		disable_virtual_lines_ft = { "python", "yaml" },
	},
}
