return {
	"iamcco/markdown-preview.nvim",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	ft = { "markdown", "mermaid", "plantuml" },
	init = require("config.utils").load("init/markdown-preview"),
}
