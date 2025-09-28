require("mini.bracketed").setup({
	files = { suffix = "f", options = { wrap = false } },
	oldfile = { suffix = "e", options = {} },
	treesitter = { suffix = "n", options = {} },
})

local map = function(modes, lhs, rhs, opts)
	vim.keymap.set(
		modes,
		lhs,
		rhs,
		vim.tbl_extend("force", {
			noremap = true,
			silent = true,
		}, opts or {})
	)
end
map("n", "[t", "<Cmd>tabprevious<CR>", { desc = ":tabprev" })
map("n", "]t", "<Cmd>tabnext<CR>", { desc = ":tabnext" })
map("n", "[T", "<Cmd>tabfirst<CR>", { desc = ":tabfirst" })
map("n", "]T", "<Cmd>tablast<CR>", { desc = ":tablast" })
