local status_ok, p = pcall(require, "toggleterm")
if not status_ok then
	return
end

p.setup({
	open_mapping = [[<c-\>]],
	direction = "float",
	float_opts = {
		border = "curved",
	},
	close_on_exit = true,
})
