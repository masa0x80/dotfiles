require("render-markdown").setup({
	headings = { "󰉫 ", "󰉬  ", "󰉭   ", "󰉮    ", "󰉯     ", "󰉰      " },
	bullets = { "󱠦" },
	checkbox = {
		unchecked = "󰄱  ",
		checked = "󰄵  ",
	},
	win_options = {
		concealcursor = {
			rendered = "",
		},
	},
	table_style = "normal",
	highlights = {
		heading = {
			backgrounds = { "DiffAdd", "DiffChange", "DiffDelete" },
			foregrounds = {
				"normal",
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
