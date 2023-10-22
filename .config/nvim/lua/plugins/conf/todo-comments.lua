require("todo-comments").setup({
	highlight = {
		pattern = [[.*<(KEYWORDS)\s*:?]],
	},
})

vim.keymap.set("n", "<Leader>V", "<Cmd>TodoTelescope<CR>", { noremap = true, silent = true, desc = "TodoTelescope" })
