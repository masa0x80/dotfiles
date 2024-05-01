return {
	"masa0x80/markdown-preview.nvim",
	branch = "feat/support-gantt",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	ft = { "markdown", "mermaid", "plantuml" },
	init = require("config.utils").load("init/markdown-preview"),
}
