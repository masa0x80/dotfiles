local status_ok, p = pcall(require, "impatient")
if not status_ok then
	return
end

p.enable_profile()
