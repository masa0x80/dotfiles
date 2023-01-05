require("trouble").setup()

vim.keymap.set("n", "<Leader>v", "<Cmd>TroubleToggle<CR>", { noremap = true, silent = true, desc = "TroubleToggle" })
