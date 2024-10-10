require("render-markdown").setup({
	render_modes = { "n" },
	heading = {
		position = "inline",
		icons = { "󰉫", "󰉬", "󰉭", "󰉮", "󰉯", "󰉰" },
		signs = { "󰉴" },
	},
	code = {
		border = "thick",
	},
	bullet = {
		icons = { "󱠦" },
		highlight = "MarkdownBullet",
	},
	checkbox = {
		unchecked = {
			icon = "󰄱",
		},
		checked = {
			icon = "󰄵",
		},
		custom = {
			todo = {
				raw = "[-]",
				rendered = "󰡖",
				highlight = "@markup.list.in_progress",
			},
		},
	},
	pipe_table = {
		style = "normal",
	},
	win_options = {
		concealcursor = {
			default = vim.api.nvim_get_option_value("concealcursor", {}),
			rendered = "",
		},
	},
})
