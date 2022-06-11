local status_ok, _ = pcall(require, "markdown-preview")
if not status_ok then
	return
end

vim.g.mkdp_filetypes = { "markdown", "plantuml" }
