return {
	{
		"masa0x80/markdown.nvim",
		branch = "feat/supports-insert-mode",
		ft = { "markdown" },
		config = require("config.utils").load("conf/markdown"),
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
