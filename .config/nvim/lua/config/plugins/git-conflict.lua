local status_ok, p = pcall(require, "git-conflict")
if not status_ok then
	return
end

p.setup({
	highlights = { -- They must have background color, otherwise the default color will be used
		incoming = "NormalFloat",
		current = "NormalFloat",
	},
})

local autocmd = vim.api.nvim_create_autocmd
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight GitConflictCurrentLabel guifg=#282c34 guibg=#98c379",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight GitConflictIncomingLabel guifg=#282c34 guibg=#56b6c2",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight GitConflictAncestorLabel guifg=#282c34 guibg=#abb2bf",
})
