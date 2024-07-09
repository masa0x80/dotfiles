require("render-markdown").setup({
	render_modes = { "n" },
	heading = {
		icons = { "# ", "#  ", "#   ", "#    ", "#     ", "#      " },
		signs = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
	},
	bullet = {
		icons = { "󱠦" },
		highlight = "Comment",
	},
	checkbox = {
		unchecked = {
			icon = "󰄱  ",
		},
		checked = {
			icon = "󰄵  ",
		},
		custom = {
			todo = {
				raw = "[-]",
				rendered = "󰡖  ",
				highlight = "@markup.raw",
			},
		},
	},
	pipe_table = {
		style = "normal",
	},
})
