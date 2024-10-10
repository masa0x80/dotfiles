local c = require("config.color")
require("onedarkpro").setup({
	colors = {
		dark_yellow = { bg = c.git_change }, -- yellow
	},
	highlights = {
		ExtraWhiteSpace = { bg = "${diff_text}" },

		GitConflictCurrentLabel = { fg = "${black}", bg = "${green}" },
		GitConflictIncomingLabel = { fg = "${black}", bg = "${blue}" },
		GitConflictAncestorLabel = { fg = "${black}", bg = "${fg}" },

		-- render-markdown
		MarkdownBullet = { fg = "${git_change}", italic = true },
		RenderMarkdownH1Bg = { bg = "${bg_statusline}", bold = true },
		RenderMarkdownH2Bg = { bg = "${bg_statusline}", bold = true },
		RenderMarkdownH3Bg = { bg = "${bg_statusline}", bold = true },
		RenderMarkdownH4Bg = { bg = "${bg_statusline}", bold = true },
		RenderMarkdownH5Bg = { bg = "${bg_statusline}", bold = true },
		RenderMarkdownH6Bg = { bg = "${bg_statusline}", bold = true },
		RenderMarkdownH1 = { fg = "${red}", bold = true },
		RenderMarkdownH2 = { fg = "${purple}", bold = true },
		RenderMarkdownH3 = { fg = "${orange}", bold = true },
		RenderMarkdownH4 = { fg = "${red}", bold = true },
		RenderMarkdownH5 = { fg = "${purple}", bold = true },
		RenderMarkdownH6 = { fg = "${orange}", bold = true },
		RenderMarkdownUnchecked = { fg = "${orange}" },
		RenderMarkdownChecked = { fg = "${green}" },
		["@markup.list.checked"] = { fg = "${green}" },
		["@markup.list.in_progress"] = { fg = "${cyan}" },
	},
})
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter" }, {
	group = "_",
	pattern = { "*" },
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
	command = [[call matchadd('ExtraWhitespace', "[\u00A0\u2000-\u200B\u202F\u3000]")]],
})

vim.cmd.colorscheme("onedark")
