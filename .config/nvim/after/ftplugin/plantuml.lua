for _, a in ipairs({
	{ "n", "comment_toggle_linewise_current" },
	{ "x", "comment_toggle_linewise_visual" },
}) do
	local mode, target = a[1], a[2]
	vim.keymap.set(mode, "\\<C-b>", "<Plug>(" .. target .. ")", {
		buffer = true,
		desc = "Toggle line-comment",
	})
end
