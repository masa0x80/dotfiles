require("mini.files").setup()

vim.api.nvim_create_user_command("Files", function()
	MiniFiles.open()
end, { desc = "Open file exproler" })
