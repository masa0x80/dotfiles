vim.g.mkdp_filetypes = { "markdown", "mermaid", "plantuml" }
vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/markdown-preview/markdown.css")
vim.g.mkdp_preview_options = {
	uml = {
		server = "http://localhost:8765",
		imageFormat = "svg",
	},
}
