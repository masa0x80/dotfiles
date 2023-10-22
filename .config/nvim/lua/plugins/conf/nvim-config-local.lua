require("config-local").setup({
	config_files = { ".nvim/local.lua" },
	hashfile = vim.fn.stdpath("data") .. "/config-local",
	autocommands_create = true,
	commands_create = true,
	silent = true,
})
