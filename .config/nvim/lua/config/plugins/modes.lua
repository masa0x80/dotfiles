local status_ok, p = pcall(require, "modes")
if not status_ok then
	return
end

p.setup({
	colors = {
		visual = "#cccccc",
	},
	line_opacity = 0.15,
})
