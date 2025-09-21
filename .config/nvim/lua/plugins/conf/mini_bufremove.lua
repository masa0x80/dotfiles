require("mini.bufremove").setup()

vim.keymap.set("n", "<Leader>dd", function()
	MiniBufremove.delete()
end, { desc = "Remove buffer" })
