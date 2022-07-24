vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_input_use_logo = true
vim.g.neovide_input_macos_alt_is_meta = true

vim.g.gui_font_default_size = 16
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "UDEV Gothic NFLG"

RefreshGuiFont = function()
	vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
	vim.g.gui_font_size = vim.g.gui_font_size + delta
	RefreshGuiFont()
end

ResetGuiFont = function()
	vim.g.gui_font_size = vim.g.gui_font_default_size
	RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "i" }, "<C-=>", function()
	ResizeGuiFont(1)
end, opts)
vim.keymap.set({ "n", "i" }, "<C-->", function()
	ResizeGuiFont(-1)
end, opts)

-- system clipboard
vim.keymap.set({ "n", "v" }, "<D-c>", '"+y', {})
vim.keymap.set("n", "<D-v>", '"+p', {})
vim.keymap.set({ "i", "c" }, "<D-v>", "<C-r>+", opts)
-- use <c-r> to insert original character without triggering things like auto-pairs
vim.keymap.set("i", "<D-r>", "<C-v>", opts)
