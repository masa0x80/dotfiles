require("render-markdown").setup({
	render_modes = { "n" },
	headings = { "󰉫 ", "󰉬  ", "󰉭   ", "󰉮    ", "󰉯     ", "󰉰      " },
	bullets = { "󱠦" },
	checkbox = {
		unchecked = "󰄱  ",
		checked = "󰄵  ",
	},
	table_style = "normal",
	highlights = {
		heading = {
			backgrounds = { "DiffAdd", "DiffChange", "DiffDelete" },
			foregrounds = {
				"Comment",
			},
		},
		bullet = "Comment",
	},
})
