local languages = {
	"bash",
	"c",
	"c_sharp",
	"cpp",
	"css",
	"csv",
	"diff",
	"dockerfile",
	"dtd", -- for xml
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitignore",
	"go",
	"graphql",
	"hcl", -- for terraform
	"html",
	"java",
	"javascript",
	"jq",
	"jsdoc",
	"json",
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
	"swift",
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

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({})

			-- 未インストールのパーサーを非同期でインストール
			local installed = {}
			for _, lang in ipairs(require("nvim-treesitter.config").get_installed("parsers")) do
				installed[lang] = true
			end

			local missing = vim.tbl_filter(function(lang)
				return not installed[lang]
			end, languages)

			if #missing > 0 then
				require("nvim-treesitter").install(missing)
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
					if not lang or not vim.treesitter.language.add(lang) then
						return
					end

					vim.treesitter.start(args.buf, lang)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			vim.keymap.set("x", "v", function()
				vim.treesitter.select("parent")
			end, { desc = "Treesitter: 選択を親ノードに拡大" })
			vim.keymap.set("x", "V", function()
				vim.treesitter.select("child")
			end, { desc = "Treesitter: 選択を子ノードに縮小" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		version = "*",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
				move = {
					set_jumps = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")

			local selections = {
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			}
			for lhs, query in pairs(selections) do
				vim.keymap.set({ "x", "o" }, lhs, function()
					select.select_textobject(query, "textobjects")
				end, { desc = "Select " .. query })
			end

			local movements = {
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
			}
			for func, keymaps in pairs(movements) do
				for lhs, query in pairs(keymaps) do
					vim.keymap.set({ "n", "x", "o" }, lhs, function()
						move[func](query, "textobjects")
					end, { desc = func .. " " .. query })
				end
			end

			vim.keymap.set("n", "<Leader>sn", function()
				swap.swap_next("@parameter.inner")
			end, { desc = "Swap next parameter" })
			vim.keymap.set("n", "<Leader>sp", function()
				swap.swap_previous("@parameter.inner")
			end, { desc = "Swap previous parameter" })
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
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
			for _, a in ipairs({
				{ "<C-_><C-_>", "n", "comment_toggle_linewise_current", "Toggle line-comment" },
				{ "<C-_><C-_>", "x", "comment_toggle_linewise_visual", "Toggle line-comment" },
				{ "<C-_><C-b>", "n", "comment_toggle_blockwise_current", "Toggle block-comment" },
				{ "<C-_><C-b>", "x", "comment_toggle_blockwise_visual", "Toggle block-comment" },
			}) do
				local lhs, mode, target, desc = a[1], a[2], a[3], a[4]

				local rhs = function()
					local ok, undo_glow = pcall(require, "undo-glow")
					if ok then
						undo_glow.highlight_changes({ hlgroup = "UgComment" })
					end

					return "<Plug>(" .. target .. ")"
				end

				local ghostty = (lhs:gsub("<C%-_>", "<C-/>"))
				for _, key in ipairs({ lhs, ghostty }) do
					vim.keymap.set(mode, key, rhs, { expr = true, remap = true, desc = desc })
				end
			end
		end,
		config = function()
			local ts_pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

			require("Comment").setup({
				pre_hook = function(ctx)
					local ok, cstr = pcall(ts_pre_hook, ctx)
					if ok and cstr then
						return cstr
					end

					return require("Comment.ft").get(vim.bo.filetype, ctx.ctype) or vim.bo.commentstring
				end,
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		version = "*",
		init = function()
			vim.g.skip_ts_context_commentstring_module = true
		end,
	},
}
