return {
	"klen/nvim-config-local",
	version = "*",
	lazy = false,
	confing = function()
		require("config-local").setup({
			config_files = { ".nvim/local.lua" },
			hashfile = vim.fn.stdpath("data") .. "/config-local",
			autocommands_create = true,
			commands_create = true,
			silent = true,
		})
	end,
}
