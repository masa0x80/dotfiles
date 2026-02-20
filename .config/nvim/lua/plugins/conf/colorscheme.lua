require("catppuccin").setup({
	flavour = "macchiato", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "macchiato",
	},
	transparent_background = true, -- disables setting the background color.
	float = {
		transparent = true,
		solid = false,
	},
	custom_highlights = function(palette)
		return {
			ExtraWhiteSpace = { fg = palette.subtext0, bg = palette.surface0 },
			MarkdownBullet = { fg = palette.overlay1, bg = palette.none },
			["@markup.strong.markdown_inline"] = { sp = palette.red, bold = true, underdouble = true },
			["@markup.strikethrough"] = { fg = palette.surface2, strikethrough = true },
		}
	end,
})
vim.cmd.colorscheme("catppuccin")

require("utils").create_autocmd({ "VimEnter", "WinEnter" }, {
	-- u00A0 ' ' no-break space
	-- u2000 ' ' en quad
	-- u2001 ' ' em quad
	-- u2002 ' ' en space
	-- u2003 ' ' em space
	-- u2004 ' ' three-per em space
	-- u2005 ' ' four-per em space
	-- u2006 ' ' six-per em space
	-- u2007 ' ' figure space
	-- u2008 ' ' punctuation space
	-- u2009 ' ' thin space
	-- u200A ' ' hair space
	-- u200B '​' zero-width space
	-- u202F ' ' narrow no-break space
	-- u3000 '　' ideographic (zenkaku) space
	command = [[call matchadd('ExtraWhiteSpace', "[\u00A0\u2000-\u200B\u202F\u3000]")]],
})
