return {
	{
		"nvim-mini/mini.nvim",
		version = "*",
		lazy = false,
	},
	{
		"nvim-mini/mini.ai",
		version = "*",
		event = "VeryLazy",
		cofnig = function()
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
					clue.gen_clues.z(),
				},
			})
		end,
	},
	{
		"nvim-mini/mini.align",
		version = "*",
		event = "VeryLazy",
		opts = {
			mappings = {
				start = "<CR>",
			},
		},
	},
	{
		"nvim-mini/mini.bracketed",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.bracketed").setup({
				file = { suffix = "f", options = { wrap = false } },
				oldfile = { suffix = "e", options = {} },
				treesitter = { suffix = "n", options = {} },
			})

			local map = function(modes, lhs, rhs, opts)
				vim.keymap.set(
					modes,
					lhs,
					rhs,
					vim.tbl_extend("force", {
						noremap = true,
						silent = true,
					}, opts or {})
				)
			end
			map("n", "[t", "<Cmd>tabprevious<CR>", { desc = ":tabprev" })
			map("n", "]t", "<Cmd>tabnext<CR>", { desc = ":tabnext" })
			map("n", "[T", "<Cmd>tabfirst<CR>", { desc = ":tabfirst" })
			map("n", "]T", "<Cmd>tablast<CR>", { desc = ":tablast" })
		end,
	},
	{
		"nvim-mini/mini.bufremove",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.bufremove").setup()

			vim.keymap.set("n", "<Leader>dd", function()
				MiniBufremove.delete()
			end, { desc = "Remove buffer" })
		end,
	},
	{
		"nvim-mini/mini.cursorword",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-mini/mini.files",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.files").setup()

			vim.api.nvim_create_user_command("Files", function()
				MiniFiles.open()
			end, { desc = "Open file exproler" })
		end,
	},
	{
		"nvim-mini/mini.indentscope",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-mini/mini.misc",
		version = "*",
		lazy = false,
		config = function()
			require("mini.misc").setup()

			MiniMisc.setup_restore_cursor()
		end,
	},
	{
		"nvim-mini/mini.move",
		version = "*",
		event = "VeryLazy",
		opts = {
			mappings = {
				left = "H",
				right = "L",
				down = "J",
				up = "K",

				line_left = "",
				line_right = "",
				line_down = "<C-g><C-j>",
				line_up = "<C-g><C-k>",
			},
			options = {
				reindent_linewise = false,
			},
		},
	},
	{
		"nvim-mini/mini.operators",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.operators").setup({
				evaluate = {
					prefix = "<C-g>=",
				},

				-- Exchange text regions
				exchange = {
					prefix = "<C-g>x",
					reindent_linewise = true,
				},

				-- Multiply (duplicate) text
				multiply = {
					prefix = "<C-g>m",
				},

				-- Replace text with register
				replace = {
					prefix = "<C-g>r",
				},

				-- Sort text
				sort = {
					prefix = "<C-g>s",
				},
			})
		end,
	},
	{
		"nvim-mini/mini.splitjoin",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.splitjoin").setup({
				mappings = {
					toggle = "ms",
					split = "ss",
					join = "sj",
				},
			})
		end,
	},
}
