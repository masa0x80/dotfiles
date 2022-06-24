local status_ok, tabline = pcall(require, "tabline")
if not status_ok then
	return
end

tabline.setup({ enable = true })

local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
	return
end

lualine.setup({
	tabline = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { require("tabline").tabline_buffers },
		lualine_x = { require("tabline").tabline_tabs },
		lualine_y = {},
		lualine_z = {},
	},
})
