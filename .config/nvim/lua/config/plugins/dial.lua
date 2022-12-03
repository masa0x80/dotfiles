local opts = { noremap = true }
local keymap = vim.api.nvim_set_keymap

local status_ok, p = pcall(require, "dial.map")
if not status_ok then
	return
end
keymap("n", "<C-a>", p.inc_normal(), opts)
keymap("n", "<C-x>", p.dec_normal(), opts)
keymap("v", "<C-a>", p.inc_visual(), opts)
keymap("v", "<C-x>", p.dec_visual(), opts)
keymap("v", "g<C-a>", p.inc_gvisual(), opts)
keymap("v", "g<C-x>", p.dec_gvisual(), opts)

local augend = require("dial.augend")
require("dial.config").augends:register_group({
	default = {
		augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
		augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
		augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
		augend.date.alias["%Y-%m-%d"], -- date (2022-02-19, etc.)
		augend.date.alias["%m/%d"], -- date (02/19, etc.)
		augend.date.alias["%H:%M"], -- date (01:28, etc.)
		augend.constant.alias.ja_weekday,
		augend.constant.alias.bool,
		augend.hexcolor.new({
			case = "lower",
		}),
		augend.semver.alias.semver,
		augend.misc.alias.markdown_header,
	},
})
