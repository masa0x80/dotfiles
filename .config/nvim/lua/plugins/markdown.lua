return {
	{
		"tadmccorkle/markdown.nvim",
		ft = { "markdown" },
		opts = {
			mappings = {
				inline_surround_toggle = "gs",
				inline_surround_toggle_line = "gss",
				inline_surround_delete = "ds",
				inline_surround_change = "cs",
				link_add = "gl",
				link_follow = false,
				go_curr_heading = "<C-g><C-c>",
				go_parent_heading = "<C-g><C-u>",
				go_next_heading = "]]",
				go_prev_heading = "[[",
			},
			inline_surround = {
				emphasis = {
					key = "i",
					txt = "*",
				},
				strong = {
					key = "b",
					txt = "**",
				},
				strikethrough = {
					key = "s",
					txt = "~~",
				},
				code = {
					key = "c",
					txt = "`",
				},
			},
			link = {
				paste = {
					enable = false,
				},
			},
			toc = {
				omit_heading = "toc omit heading",
				omit_section = "toc omit section",
				markers = { "-" },
			},
			on_attach = function(bufnr)
				local map = vim.keymap.set
				local opts = { buffer = bufnr }
				map({ "n" }, "o", "<Cmd>MDListItemBelow<CR>", opts)
				map({ "n" }, "O", "<Cmd>MDListItemAbove<CR>", opts)
				map({ "i" }, "<CR>", "<Cmd>MDListItemBelow<CR>", opts)
			end,
		},
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
