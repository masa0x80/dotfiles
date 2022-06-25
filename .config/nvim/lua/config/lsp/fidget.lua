local status_ok, p = pcall(require, "fidget")
if not status_ok then
	return
end

p.setup({
	text = {
		spinner = "dots",
	},
})

vim.cmd([[ highlight FidgetTask ctermfg=blue ]])
