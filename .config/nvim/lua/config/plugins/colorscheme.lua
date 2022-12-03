local cmp_status_ok, p = pcall(require, "tokyonight")
if not cmp_status_ok then
	return
end

p.setup({
	style = "night",
})

vim.cmd([[colorscheme tokyonight]])
