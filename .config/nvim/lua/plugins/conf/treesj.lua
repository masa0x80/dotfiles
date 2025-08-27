local treesj = require("treesj")
treesj.setup({
	use_default_keymaps = false,
})

local map = vim.keymap.set
map("n", "<C-g><C-g>m", function()
	treesj.toggle()
end, { noremap = true, silent = true, desc = "SplitJoin - toggle" })
map("n", "<C-g><C-g>M", function()
	treesj.toggle({ split = { recursive = true } })
end, { noremap = true, silent = true, desc = "SplitJoin - toggle (recursive)" })

map("n", "<C-g><C-g>s", function()
	treesj.split()
end, { noremap = true, silent = true, desc = "SplitJoin - split" })
map("n", "<C-g><C-g>S", function()
	treesj.split({ split = { recursive = true } })
end, { noremap = true, silent = true, desc = "SplitJoin - split (recursive)" })

map("n", "<C-g><C-g>j", function()
	treesj.join()
end, { noremap = true, silent = true, desc = "SplitJoin - join" })
map("n", "<C-g><C-g>J", function()
	treesj.join({ split = { recursive = true } })
end, { noremap = true, silent = true, desc = "SplitJoin - join (recursive)" })
