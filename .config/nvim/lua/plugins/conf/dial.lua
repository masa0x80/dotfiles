local augend = require("dial.augend")
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
		augend.date.new({
			pattern = "%Y-%m",
			default_kind = "day",
			-- if true, it does not match dates which does not exist, such as 2022/05/32
			only_valid = true,
			-- if true, it only matches dates with word boundary
			word = false,
		}),
		augend.date.new({
			pattern = "%Y/%m",
			default_kind = "day",
			-- if true, it does not match dates which does not exist, such as 2022/05/32
			only_valid = true,
			-- if true, it only matches dates with word boundary
			word = false,
		}),
	},
})
