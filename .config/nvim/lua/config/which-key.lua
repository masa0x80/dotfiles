local status_ok, p = pcall(require, "which-key")
if not status_ok then
	return
end

p.setup({
	triggers_blacklist = {
		n = { ";" },
	},
})
