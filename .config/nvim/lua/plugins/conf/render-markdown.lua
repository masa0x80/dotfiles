local c = require("config.color")
local set_hl = vim.api.nvim_set_hl
set_hl(0, "MarkdownBullet", { fg = c.dark_red })

require("render-markdown").setup({
	render_modes = { "n" },
	heading = {
		position = "inline",
		icons = {
			"󱠦 ",
			"󱠦 󱠦 ",
			"󱠦 󱠦 󱠦 ",
			"󱠦 󱠦 󱠦 󱠦 ",
			"󱠦 󱠦 󱠦 󱠦 󱠦 ",
			"󱠦 󱠦 󱠦 󱠦 󱠦 󱠦 ",
		},
		signs = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
	},
	code = {
		border = "thick",
	},
	bullet = {
		position = "inline",
		icons = { "󰐝" },
		highlight = "MarkdownBullet",
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
	win_options = {
		concealcursor = {
			default = vim.api.nvim_get_option_value("concealcursor", {}),
			rendered = "",
		},
	},
})
