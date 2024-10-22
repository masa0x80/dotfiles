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
		RenderMarkdownH1Bg = { bg = "${indentline}", bold = true },
		RenderMarkdownH2Bg = { bg = "${indentline}", bold = true },
		RenderMarkdownH3Bg = { bg = "${indentline}", bold = true },
		RenderMarkdownH4Bg = { bg = "${indentline}", bold = true },
		RenderMarkdownH5Bg = { bg = "${indentline}", bold = true },
		RenderMarkdownH6Bg = { bg = "${indentline}", bold = true },
		RenderMarkdownH1 = { fg = "${comment}" },
		RenderMarkdownH2 = { fg = "${comment}" },
		RenderMarkdownH3 = { fg = "${comment}" },
		RenderMarkdownH4 = { fg = "${comment}" },
		RenderMarkdownH5 = { fg = "${comment}" },
		RenderMarkdownH6 = { fg = "${comment}" },
		RenderMarkdownUnchecked = { fg = "${orange}" },
		RenderMarkdownChecked = { fg = "${green}" },
		RenderMarkdownCodeInline = { fg = "${virtual_text_error}" },
		["@markup.heading.1.markdown"] = { fg = "${red}", bold = true },
		["@markup.heading.2.markdown"] = { fg = "${cyan}", bold = true },
		["@markup.heading.3.markdown"] = { fg = "${green}", bold = true },
		["@markup.heading.4.markdown"] = { fg = "${purple}", bold = true },
		["@markup.heading.5.markdown"] = { fg = "${virtual_text_warning}", bold = true },
		["@markup.heading.6.markdown"] = { fg = "${fg_gutter_inactive}", bold = true },
		["@markup.list.checked"] = { fg = "${green}" },
		["@markup.list.in_progress"] = { fg = "${cyan}" },

		-- neo-tree
		NeoTreeDirectoryIcon = { fg = "${blue}" },
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
