local status_ok, modes = pcall(require, "modes")
if not status_ok then
	return
end

modes.setup()
