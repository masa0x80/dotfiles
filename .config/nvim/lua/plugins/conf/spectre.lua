local keymap = vim.keymap.set
keymap({ "n", "v" }, "<Leader>R", function()
	require("spectre").open_visual({ select_word = true, path = vim.fn.expand("%") })
end, { noremap = true, silent = true, desc = "[R] Replace current word" })
keymap("n", "<Leader>rw", function()
	require("spectre").open({ select_word = true, path = "**/*" })
end, { noremap = true, silent = true, desc = "[rw] Replace current word" })
