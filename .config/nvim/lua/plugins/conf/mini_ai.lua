local gen_ai_spec = require("mini.extra").gen_ai_spec
require("mini.ai").setup({
	custom_textobjects = {
		B = gen_ai_spec.buffer(),
		D = gen_ai_spec.diagnostic(),
		I = gen_ai_spec.indent(),
		L = gen_ai_spec.line(),
		N = gen_ai_spec.number(),
	},
})

local function mode_nx(keys)
	return { mode = "n", keys = keys }, { mode = "x", keys = keys }
end
local clue = require("mini.clue")
clue.setup({
	triggers = {
		-- Leader triggers
		mode_nx("<Leader>"),

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		mode_nx("g"),

		mode_nx("<C-g>"),
		mode_nx("<C-;>"),
		mode_nx("<C-,>"),

		-- Marks
		mode_nx("'"),
		mode_nx("`"),

		-- Registers
		mode_nx('"'),
		{ mode = "i", keys = "<C-r>" },
		{ mode = "c", keys = "<C-r>" },

		-- Window commands
		{ mode = "n", keys = "<C-w>" },

		-- bracketed commands
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },

		-- `z` key
		mode_nx("z"),

		-- surround
		mode_nx("s"),

		-- text object
		{ mode = "x", keys = "i" },
		{ mode = "x", keys = "a" },
		{ mode = "o", keys = "i" },
		{ mode = "o", keys = "a" },

		-- option toggle (mini.basics)
		{ mode = "n", keys = "m" },
	},

	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		clue.gen_clues.builtin_completion(),
		clue.gen_clues.g(),
		clue.gen_clues.marks(),
		clue.gen_clues.registers({ show_contents = true }),
		clue.gen_clues.windows({ submode_resize = true, submode_move = true }),
		clue.gen_clues.z(),
	},
})
