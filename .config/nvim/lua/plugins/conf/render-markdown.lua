require("render-markdown").setup({
	headings = { "󰉫 ", "󰉬  ", "󰉭   ", "󰉮    ", "󰉯     ", "󰉰      " },
	bullets = { "󱠦" },
	table_style = "normal",
	highlights = {
		heading = {
			backgrounds = { "DiffAdd", "DiffChange", "DiffDelete" },
			foregrounds = {
				"comment",
				"markdownH2",
				"markdownH3",
				"markdownH4",
				"markdownH5",
				"markdownH6",
			},
		},
		bullet = "Comment",
	},
})
