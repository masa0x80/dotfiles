local augend = require("dial.augend")
require("dial.config").augends:register_group({
	default = {
		augend.integer.alias.decimal_int,
		augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
		augend.integer.alias.octal,
		augend.integer.alias.binary,
		augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
		augend.date.alias["%Y-%m-%d"], -- date (2022-02-19, etc.)
		augend.date.alias["%m/%d"], -- date (02/19, etc.)
		augend.date.alias["%H:%M"], -- date (01:28, etc.)
		augend.constant.alias.ja_weekday,
		augend.constant.alias.bool,
		augend.constant.new({ elements = { "let", "const" } }),
		augend.hexcolor.new({
			case = "lower",
		}),
		augend.semver.alias.semver,
		augend.misc.alias.markdown_header,
	},
})
