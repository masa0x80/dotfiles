local status_ok, _ = pcall(require, "illuminate")
if not status_ok then
	return
end

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight illuminatedWord cterm=underline gui=underline",
})
