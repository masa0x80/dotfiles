for _, a in ipairs({
	{ "n", "comment_toggle_linewise_current" },
	{ "x", "comment_toggle_linewise_visual" },
}) do
	local mode, target = a[1], a[2]
	for _, lhs in ipairs({ "<C-_><C-b>", "<C-/><C-b>" }) do
		vim.keymap.set(mode, lhs, "<Plug>(" .. target .. ")", {
			buffer = true,
			desc = "Toggle line-comment",
		})
	end
end
