require("insx.preset.standard").setup()

local insx = require("insx")
for _, c in ipairs({ '"', "'", "`" }) do
	insx.add(
		"<C-]>",
		insx.with(
			require("insx.recipe.fast_wrap")({
				close = c,
			}),
			{
				insx.with.undopoint(true),
				insx.with.in_string(false),
				insx.with.in_comment(false),
				insx.with.nomatch([[\\\%#]]),
				insx.with.nomatch([[\a\%#]]),
			}
		)
	)
	-- ` は2個挿入するのをやめる
	if c == "`" then
		vim.api.nvim_del_keymap("i", c)
	end
end

-- nvim-insxというプラグインの紹介 https://zenn.dev/hrsh7th/articles/dd7ea5a0e4a7b9
insx.add("<Space>", {
	enabled = function(ctx)
		-- カーソル左側がマルチバイト文字である
		local before_non_ascii = ctx.match([=[[^\x00-\x7F]\%#]=])
		-- カーソル右側がASCII文字列で、スペースなしでマルチバイトが続いている
		local after_ascii_without_space = ctx.match([=[\%#[\x00-\x7F]\+[^\x00-\x7F]]=])
		return before_non_ascii and after_ascii_without_space
	end,
	action = function(ctx)
		ctx.send("<Space>")
		local row, col = ctx.row(), ctx.col()
		ctx.move(unpack(ctx.search([=[\%#[\x00-\x7F]\+\zs]=])))
		ctx.send("<Space>")
		ctx.move(row, col)
	end,
})
