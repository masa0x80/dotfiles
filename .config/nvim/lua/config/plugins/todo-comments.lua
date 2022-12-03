local status_ok, p = pcall(require, "todo-comments")
if not status_ok then
	return
end

p.setup({
	highlight = {
		pattern = [[.*<(KEYWORDS)\s*:?]],
	},
})

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<Leader>V", "<Cmd>TodoTelescope<CR>", opts)
