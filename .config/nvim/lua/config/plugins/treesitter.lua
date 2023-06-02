local languages = {
	"bash",
	"css",
	"dockerfile",
	"go",
	"graphql",
	"java",
	"javascript",
	"jsdoc",
	"json",
	"html",
	"lua",
	"make",
	"python",
	"ruby",
	"rust",
	"scss",
	"toml",
	"tsx",
	"typescript",
	"yaml",
	"vim",
	"vimdoc",
	"markdown",
	"markdown_inline",
}

require("nvim-treesitter.configs").setup({
	ensure_installed = languages,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			node_incremental = "v",
			scope_incremental = "<C-i>",
			node_decremental = "V",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>ta"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>tA"] = "@parameter.inner",
			},
		},
	},
	autotag = {
		enable = true,
	},
})
