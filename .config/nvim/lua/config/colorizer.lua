local cmp_status_ok, p = pcall(require, "colorizer")
if not cmp_status_ok then
	return
end

p.setup()
