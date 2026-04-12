return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = "*",
		event = "VeryLazy",
		build = ":TSUpdate",
		config = function()
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
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		version = "*",
	},
	{
		"windwp/nvim-ts-autotag",
		version = "*",
	},
	{
		"David-Kunz/treesitter-unit",
		version = "*",
		keys = {
			{ "iu", ':lua require"treesitter-unit".select()<CR>', mode = "x" },
			{ "au", ':lua require"treesitter-unit".select(true)<CR>', mode = "x" },
			{ "iu", ':<C-u>lua require"treesitter-unit".select()<CR>', mode = "o" },
			{ "au", ':<C-u>lua require"treesitter-unit".select(true)<CR>', mode = "o" },
		},
	},
	{
		"kiyoon/treesitter-indent-object.nvim",
		version = "*",
		keys = {
			{
				"ai",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>",
				mode = { "x", "o" },
				desc = "Select context-aware indent (outer)",
			},
			{
				"aI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>",
				mode = { "x", "o" },
				desc = "Select context-aware indent (outer, line-wise)",
			},
			{
				"ii",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>",
				mode = { "x", "o" },
				desc = "Select context-aware indent (inner, partial range)",
			},
			{
				"iI",
				"<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>",
				mode = { "x", "o" },
				desc = "Select context-aware indent (inner, entire range)",
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		version = "*",
		event = { "VeryLazy" },
		init = function()
			local map = vim.api.nvim_set_keymap

			-- line-comment
			map("n", "<C-_><C-_>", "gcc", { desc = "Toggle line-comment" })
			map("v", "<C-_><C-_>", "gc", { desc = "Toggle line-comment" })

			-- block-comment
			map("n", "<C-_><C-b>", "gbc", { desc = "Toggle block-comment" })
			map("v", "<C-_><C-b>", "gb", { desc = "Toggle block-comment" })

			-- line-comment (for Ghostty)
			map("n", "<C-/><C-/>", "gcc", { desc = "Toggle line-comment" })
			map("v", "<C-/><C-/>", "gc", { desc = "Toggle line-comment" })

			-- block-comment (for Ghostty)
			map("n", "<C-/><C-b>", "gbc", { desc = "Toggle block-comment" })
			map("v", "<C-/><C-b>", "gb", { desc = "Toggle block-comment" })
		end,
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		version = "*",
	},
}
