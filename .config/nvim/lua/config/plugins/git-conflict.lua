require("git-conflict").setup({
	highlights = { -- They must have background color, otherwise the default color will be used
		incoming = "NormalFloat",
		current = "NormalFloat",
	},
})
