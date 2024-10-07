return {
	{
		"tadmccorkle/markdown.nvim",
		ft = { "markdown" },
		config = require("config.utils").load("conf/markdown"),
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		config = require("config.utils").load("conf/render-markdown"),
	},
	{
		"nvim-treesitter/nvim-treesitter",
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function(plugin)
			if vim.fn.executable("npx") then
				vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
			else
				vim.cmd([[Lazy load markdown-preview.nvim]])
				vim.fn["mkdp#util#install"]()
			end
		end,
		ft = { "markdown", "mermaid", "plantuml" },
		init = require("config.utils").load("init/markdown-preview"),
	},
}
