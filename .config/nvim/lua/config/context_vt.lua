local status_ok, p = pcall(require, "nvim_context_vt")
if not status_ok then
  return
end

p.setup({
  disable_virtual_lines_ft = { 'yaml' },
})
