return {
	{
		"tadmccorkle/markdown.nvim",
		version = "*",
		ft = { "markdown" },
		config = require("utils").load("conf/markdown"),
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		version = "*",
		ft = { "markdown" },
		config = require("utils").load("conf/render-markdown"),
	},
	{
		"iamcco/markdown-preview.nvim",
		version = "*",
		build = function(plugin)
			if vim.fn.executable("npx") then
				vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
			else
				vim.cmd([[Lazy load markdown-preview.nvim]])
				vim.fn["mkdp#util#install"]()
			end
		end,
		ft = { "markdown", "mermaid", "plantuml" },
		init = require("utils").load("init/markdown-preview"),
	},
}
