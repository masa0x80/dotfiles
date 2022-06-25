local status_ok, p = pcall(require, "todo-comments")
if not status_ok then
	return
end

p.setup({
	highlight = {
		pattern = [[.*<(KEYWORDS)\s*:?]],
	},
})
