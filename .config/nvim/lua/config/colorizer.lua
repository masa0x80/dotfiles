local cmp_status_ok, colorizer = pcall(require, "colorizer")
if not cmp_status_ok then
	return
end

colorizer.setup()
