require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	float = {
		transparent = true,
		solid = false,
	},
	custom_highlights = function(palette)
		return {
			ExtraWhiteSpace1 = { underdotted = true },
			ExtraWhiteSpace2 = { fg = palette.base, bg = palette.overlay2 },
			ExtraWhiteSpace3 = { fg = palette.text, bg = palette.mantle },
			ExtraWhiteSpace4 = { fg = palette.overlay2 },
			MarkdownBullet = { fg = palette.overlay1, bg = palette.none },
			["@markup.strong.markdown_inline"] = { sp = palette.red, bold = true, underdouble = true },
			["@markup.strikethrough"] = { fg = palette.surface2, strikethrough = true },
			NavicIconsDefault = { fg = palette.mauve },
			NavicIconsArray = { fg = palette.yellow },
			NavicIconsBoolean = { fg = palette.peach },
			NavicIconsClass = { fg = palette.yellow },
			NavicIconsColor = { fg = palette.green },
			NavicIconsConstant = { fg = palette.peach },
			NavicIconsConstructor = { fg = palette.blue },
			NavicIconsEnum = { fg = palette.mauve },
			NavicIconsEnumMember = { fg = palette.yellow },
			NavicIconsEvent = { fg = palette.yellow },
			NavicIconsField = { fg = palette.mauve },
			NavicIconsFile = { fg = palette.blue },
			NavicIconsFolder = { fg = palette.peach },
			NavicIconsFunction = { fg = palette.blue },
			NavicIconsInterface = { fg = palette.green },
			NavicIconsKey = { fg = palette.sky },
			NavicIconsKeyword = { fg = palette.sky },
			NavicIconsMethod = { fg = palette.blue },
			NavicIconsModule = { fg = palette.peach },
			NavicIconsNamespace = { fg = palette.red },
			NavicIconsNull = { fg = palette.grey },
			NavicIconsNumber = { fg = palette.peach },
			NavicIconsObject = { fg = palette.red },
			NavicIconsOperator = { fg = palette.red },
			NavicIconsPackage = { fg = palette.yellow },
			NavicIconsProperty = { fg = palette.sky },
			NavicIconsReference = { fg = palette.peach },
			NavicIconsSnippet = { fg = palette.red },
			NavicIconsString = { fg = palette.green },
			NavicIconsStruct = { fg = palette.mauve },
			NavicIconsText = { fg = palette.overlay0 },
			NavicIconsTypeParameter = { fg = palette.red },
			NavicIconsUnit = { fg = palette.green },
			NavicIconsValue = { fg = palette.peach },
			NavicIconsVariable = { fg = palette.mauve },
			NormalFloat = { bg = palette.surface0 },
		}
	end,
})
vim.cmd.colorscheme("catppuccin-nvim")

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
	callback = function()
		vim.fn.matchadd("ExtraWhiteSpace1", "[\u{00A0}]", 10)
		vim.fn.matchadd("ExtraWhiteSpace2", "[\u{2000}-\u{200A}\u{202F}]", 10)
		vim.fn.matchadd("ExtraWhiteSpace3", "[\u{200B}\u{3000}]", 10)
		vim.fn.matchadd("ExtraWhiteSpace4", [[\s\+$]], 10)
	end,
})
