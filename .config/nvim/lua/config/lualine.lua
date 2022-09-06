local status_ok, p = pcall(require, "lualine")
if not status_ok then
	return
end

p.setup({
	sections = { lualine_x = { "g:coc_status", "encoding", "fileformat", "filetype" } },
})
