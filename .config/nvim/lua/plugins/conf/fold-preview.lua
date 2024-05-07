local fp = require("fold-preview")
local keymap = vim.keymap
keymap.amend = require("keymap-amend")

fp.setup({
	default_keybindings = false,
})

keymap.amend("n", "K", function(original)
	if not fp.show_preview() then
		original()
	end
end)

require("pretty-fold").setup({})
