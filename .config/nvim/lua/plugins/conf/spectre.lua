local map = vim.keymap.set
map({ "n", "v" }, "<Leader>R", function()
	require("spectre").open_visual({ select_word = true, path = vim.fn.expand("%") })
end, { noremap = true, silent = true, desc = "[R] Replace current word" })
map("n", "<Leader>rw", function()
	require("spectre").open({ select_word = true, path = "**/*" })
end, { noremap = true, silent = true, desc = "[rw] Replace current word" })
