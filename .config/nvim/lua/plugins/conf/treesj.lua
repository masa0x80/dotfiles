local treesj = require("treesj")
treesj.setup({
	use_default_keymaps = false,
})

vim.keymap.set("n", ";m", function()
	treesj.toggle({ split = { recursive = true } })
end, { noremap = true, silent = true, desc = "SplitJoin - toggle" })

vim.keymap.set("n", ";s", function()
	treesj.split({ split = { recursive = true } })
end, { noremap = true, silent = true, desc = "SplitJoin - split" })

vim.keymap.set("n", ";j", function()
	treesj.join({ split = { recursive = true } })
end, { noremap = true, silent = true, desc = "SplitJoin - join" })
