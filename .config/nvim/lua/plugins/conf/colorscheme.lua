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
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	group = "_",
	pattern = { "*" },
	callback = function()
		vim.api.nvim_set_hl(0, "ExtraWhiteSpace", { bg = "#2b5d63" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#dbb671" })
	end,
})
