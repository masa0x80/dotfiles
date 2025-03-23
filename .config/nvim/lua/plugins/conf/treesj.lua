local treesj = require("treesj")
treesj.setup({
	use_default_keymaps = false,
})

local map = vim.keymap.set
map("n", "<C-;>m", function()
	treesj.toggle({ split = { recursive = true } })
end, { noremap = true, silent = true, desc = "SplitJoin - toggle" })

map("n", "<C-;>s", function()
	treesj.split({ split = { recursive = true } })
end, { noremap = true, silent = true, desc = "SplitJoin - split" })

map("n", "<C-;>j", function()
	treesj.join({ split = { recursive = true } })
end, { noremap = true, silent = true, desc = "SplitJoin - join" })
