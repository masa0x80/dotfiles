local status_ok, p = pcall(require, "scrollbar")
if not status_ok then
	return
end

local autocmd = vim.api.nvim_create_autocmd
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarHandle guibg=#abb2bf",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarSearch guifg=#5c6370",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarSearchHandle guifg=#5c6370 guibg=#abb2bf",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarError guifg=#e06c75",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarErrorHandle guifg=#e06c75 guibg=#abb2bf",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarWarn guifg=#e5c07b",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarWarnHandle guifg=#e5c07b guibg=#abb2bf",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarInfo guifg=#61afef",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarInfoHandle guifg=#61afef guibg=#abb2bf",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarHint guifg=#56b6c2",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarHintHandle guifg=#56b6c2 guibg=#abb2bf",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarHint guifg=#56b6c2",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarHintHandle guifg=#56b6c2 guibg=#abb2bf",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarMisc guifg=#3e4452",
})
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight ScrollbarMiscHandle guifg=#3e4452 guibg=#abb2bf",
})

p.setup({
	set_highlights = false,
	handlers = {
		search = true,
	},
})
require("scrollbar.handlers.search").setup()
