local neogit = require("neogit")
neogit.setup({
	kind = "replace",
})

vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "NeogitPushComplete",
	group = "_",
	callback = neogit.close,
})
