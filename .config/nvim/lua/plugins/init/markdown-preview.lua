vim.g.mkdp_filetypes = { "markdown", "mermaid", "plantuml" }
vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/markdown-preview/markdown.css")
vim.g.mkdp_preview_options = {
	disable_sync_scroll = true,
	uml = {
		server = "http://127.0.0.1:8765",
		imageFormat = "svg",
	},
}
