local languages = {
	"bash",
	"c",
	"c_sharp",
	"cpp",
	"css",
	"csv",
	"diff",
	"dockerfile",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitignore",
	"go",
	"graphql",
	"html",
	"java",
	"javascript",
	"jq",
	"jsdoc",
	"json",
	"jsonc",
	"kotlin",
	"lua",
	"luadoc",
	"luap",
	"make",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"ruby",
	"rust",
	"scss",
	"sql",
	-- "swift",
	"terraform",
	"toml",
	"tsv",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
}

require("nvim-ts-autotag").setup({})

require("nvim-treesitter.configs").setup({
	ensure_installed = languages,
	highlight = {
		enable = true,
		-- 調子悪いのでオフに
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
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
				["f]"] = "@function.outer",
				["c]"] = "@class.outer",
			},
			goto_next_end = {
				["F]"] = "@function.outer",
				["C]"] = "@class.outer",
			},
			goto_previous_start = {
				["f["] = "@function.outer",
				["c["] = "@class.outer",
			},
			goto_previous_end = {
				["F["] = "@function.outer",
				["C["] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>sn"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>sp"] = "@parameter.inner",
			},
		},
	},
	-- https://github.com/tadmccorkle/markdown.nvim
	markdown = {
		enable = true,
	},
})
