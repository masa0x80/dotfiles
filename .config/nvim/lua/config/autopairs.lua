local status_ok, p = pcall(require, "nvim-autopairs")
if not status_ok then
	return
end

p.setup()
