return {
	"iamcco/markdown-preview.nvim",
	build = "cd app && npm install",
	ft = { "markdown", "mermaid", "plantuml" },
	init = require("config.utils").load("init/markdown-preview"),
}
