return {
	"monaqa/dial.nvim",
	version = "*",
	keys = {
		{ "<C-a>", "<Plug>(dial-increment)", mode = { "n", "v" } },
		{ "<C-x>", "<Plug>(dial-decrement)", mode = { "n", "v" } },
		{ "g<C-a>", "g<Plug>(dial-g-increment)", mode = { "n", "v" } },
		{ "g<C-x>", "g<Plug>(dial-g-decrement)", mode = { "n", "v" } },
	},
	config = function()
		local augend = require("dial.augend")
		local month_augends = {}
		for _, pattern in ipairs({ "%Y-%m", "%Y/%m" }) do
			table.insert(
				month_augends,
				augend.date.new({
					pattern = pattern,
					default_kind = "month",
					only_valid = true, -- 存在しない日付にはマッチさせない
					word = false, -- 単語境界でなくてもマッチさせる
				})
			)
		end
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal,
				augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
				augend.integer.alias.octal,
				augend.integer.alias.binary,
				augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
				augend.date.alias["%Y-%m-%d"], -- date (2022-02-19, etc.)
				augend.date.alias["%-m/%-d"], -- date (2/1, etc.)
				augend.date.alias["%H:%M"], -- date (01:28, etc.)
				augend.constant.alias.ja_weekday,
				augend.constant.alias.bool,
				augend.constant.new({ elements = { "let", "const" } }),
				augend.hexcolor.new({
					case = "lower",
				}),
				augend.semver.alias.semver,
				augend.misc.alias.markdown_header,
				unpack(month_augends),
			},
		})
	end,
}
