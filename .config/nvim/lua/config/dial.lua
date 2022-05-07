local opts = { noremap = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-a>", require("dial.map").inc_normal(), opts)
keymap("n", "<C-x>", require("dial.map").dec_normal(), opts)
keymap("v", "<C-a>", require("dial.map").inc_visual(), opts)
keymap("v", "<C-x>", require("dial.map").dec_visual(), opts)
keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), opts)
keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), opts)

local augend = require("dial.augend")
require("dial.config").augends:register_group({
	default = {
		augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
		augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
		augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
		augend.date.alias["%Y-%m-%d"], -- date (2022/02/19, etc.)
		augend.date.alias["%m/%d"], -- date (2022/02/19, etc.)
		augend.date.alias["%H:%M"], -- date (2022/02/19, etc.)
		augend.constant.alias.ja_weekday,
		augend.constant.alias.bool,
		augend.hexcolor.new({
			case = "lower",
		}),
		augend.semver.alias.semver,
		augend.misc.alias.markdown_header,
	},
})
