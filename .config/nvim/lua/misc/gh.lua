vim.api.nvim_create_user_command("GhOpenPR", function()
	vim.fn.system("gh pr view --web")
end, {})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "<Leader>gp", "<Cmd>GhOpenPR<CR>", opts)
