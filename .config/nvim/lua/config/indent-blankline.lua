local status_ok, p = pcall(require, "indent_blankline")
if not status_ok then
	return
end

p.setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})
