local status_ok, p = pcall(require, "lightspeed")
if not status_ok then
	return
end

p.setup({})
