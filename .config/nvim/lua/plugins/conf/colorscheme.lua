---@diagnostic disable-next-line: missing-fields
require("everforest").setup({
	on_highlights = function(hl, palette)
		hl.ExtraWhiteSpace = { fg = palette.none, bg = palette.bg_blue }
		hl.MarkdownBullet = { fg = palette.grey1, bg = palette.none }
		hl.SnacksPickerDir = { fg = palette.grey1 }
		hl.SnacksPickerPathHidden = { fg = palette.grey1 }
		hl.SnacksPickerGitStatusUntracked = { fg = palette.purple }
		hl["@markup.strong.markdown_inline"] = { sp = palette.red, bold = true, underdouble = true }
		hl.FlashMatch = { fg = palette.grey1, underline = true }
		hl.FlashCurrent = { fg = palette.purple }
		hl.FlashLabel = { fg = palette.orange }
		hl.FlashBackdrop = { fg = palette.grey1 }
	end,
})
require("everforest").load()

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
