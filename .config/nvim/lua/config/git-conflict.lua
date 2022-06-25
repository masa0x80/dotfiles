local status_ok, p = pcall(require, "git-conflict")
if not status_ok then
	return
end

p.setup()
