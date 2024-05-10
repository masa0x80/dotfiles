return {
	{
		"masa0x80/nvim-markdown",
		branch = "feat/disable-fold-feature",
		ft = { "markdown" },
		init = function()
			vim.g.vim_markdown_no_default_key_mappings = 1
		end,
		config = function()
			vim.api.nvim_create_autocmd({ "FileType" }, {
				group = "_",
				pattern = "markdown",
				callback = function()
					local keymap = vim.keymap.set
					keymap({ "n", "v" }, "]]", "<Plug>Markdown_MoveToNextHeader", { buffer = true })
					keymap({ "n", "v" }, "[[", "<Plug>Markdown_MoveToPreviousHeader", { buffer = true })
					keymap({ "n", "v" }, "][", "<Plug>Markdown_MoveToNextSiblingHeader", { buffer = true })
					keymap({ "n", "v" }, "[]", "<Plug>Markdown_MoveToPreviousSiblingHeader", { buffer = true })
					keymap({ "n", "v" }, "<C-g><C-u>", "<Plug>Markdown_MoveToParentHeader", { buffer = true })
					keymap({ "n", "v" }, "<C-g><C-c>", "<Plug>Markdown_MoveToCurHeader", { buffer = true })
					keymap("i", "<TAB>", "<Plug>Markdown_Jump", { buffer = true })
					keymap({ "v", "i" }, "<C-k>", "<Plug>Markdown_CreateLink", { buffer = true })
					keymap("n", "o", "<Plug>Markdown_NewLineBelow", { buffer = true })
					keymap("n", "O", "<Plug>Markdown_NewLineAbove", { buffer = true })
					keymap("i", "<CR>", "<Plug>Markdown_NewLineBelow", { buffer = true })
				end,
			})
		end,
	},
	{
		"MeanderingProgrammer/markdown.nvim",
		name = "render-markdown",
		ft = { "markdown" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = require("config.utils").load("conf/render-markdown"),
	},
	{
		"masa0x80/markdown-preview.nvim",
		branch = "feat/support-gantt",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown", "mermaid", "plantuml" },
		init = require("config.utils").load("init/markdown-preview"),
	},
}
