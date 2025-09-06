vim.g.mkdp_filetypes = { "markdown", "mermaid", "plantuml" }
vim.g.mkdp_theme = "light"
vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/markdown-preview/markdown.css")
local default_options = {
	disable_sync_scroll = true,
	uml = {
		server = "http://127.0.0.1:8765",
		imageFormat = "svg",
	},
}
vim.g.mkdp_preview_options = default_options

vim.api.nvim_create_user_command("EnableMDPScroll", function()
	vim.g.mkdp_preview_options = vim.tbl_deep_extend("force", default_options, { disable_sync_scroll = false })
end, {})
vim.api.nvim_create_user_command("DisableMDPScroll", function()
	vim.g.mkdp_preview_options = vim.tbl_deep_extend("force", default_options, { disable_sync_scroll = true })
end, {})
