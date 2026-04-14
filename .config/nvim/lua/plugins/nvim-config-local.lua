return {
	"klen/nvim-config-local",
	version = "*",
	lazy = false,
	config = function()
		require("config-local").setup({
			config_files = { ".nvim.lua" },
			hashfile = vim.fn.stdpath("data") .. "/config-local",
			autocommands_create = true,
			commands_create = true,
			silent = true,
		})
	end,
}
