local status_ok, lightspeed = pcall(require, "lightspeed")
if not status_ok then
	return
end

lightspeed.setup({})
