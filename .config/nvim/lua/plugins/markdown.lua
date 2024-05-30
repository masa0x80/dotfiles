return {
	{
		"masa0x80/markdown.nvim",
		branch = "feat/supports-insert-mode",
		ft = { "markdown" },
		config = require("config.utils").load("conf/markdown"),
	},
	{
		"MeanderingProgrammer/markdown.nvim",
		commit = "fbd4c45dc4a8e7490c6cfb1827360f5943a76b76",
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
