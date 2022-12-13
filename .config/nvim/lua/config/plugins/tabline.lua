local status_ok, p = pcall(require, "tabline")
if not status_ok then
	return
end

p.setup({
	options = {
		show_filename_only = true,
	},
})

require("lualine").setup({
	sections = { lualine_x = { "g:coc_status", "encoding", "fileformat", "filetype" } },
	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { p.tabline_buffers },
		lualine_x = { p.tabline_tabs },
		lualine_y = {},
		lualine_z = {},
	},
})

-- NOTE: tabline読み込み後に発火させる
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
	group = "_",
	once = true,
	callback = function()
		p.toggle_show_all_buffers()
	end,
})
