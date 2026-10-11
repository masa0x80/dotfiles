vim.opt_local.foldmethod = "marker"
vim.opt_local.foldlevel = 0

for mode, target in pairs({
	n = "comment_toggle_linewise_current",
	x = "comment_toggle_linewise_visual",
}) do
	vim.keymap.set(mode, "\\<C-b>", "<Plug>(" .. target .. ")", {
		buffer = true,
		desc = "Toggle line-comment",
	})
end
