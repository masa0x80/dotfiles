local status_ok, incline = pcall(require, "incline")
if not status_ok then
	return
end

incline.setup()
