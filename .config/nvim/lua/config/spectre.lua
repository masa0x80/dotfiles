local status_ok, spectre = pcall(require, "spectre")
if not status_ok then
	return
end

spectre.setup()

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<Leader>S", '<Cmd>lua require("spectre")<CR>', opts)
keymap("n", "<Leader>sw", '<Cmd>lua require("spectre").open_visual({select_word=true})<CR>', opts)
keymap("v", "<Leader>s", '<Cmd>lua require("spectre").open_visual()<CR>', opts)
keymap("n", "<Leader>sr", '<Cmd>lua require("spectre").open_file_search()<CR>', opts)
