return {
	"haringsrob/nvim_context_vt",
	event = { "BufNewFile", "BufRead" },
	opts = {
		disable_virtual_lines_ft = { "python", "yaml" },
	},
}
