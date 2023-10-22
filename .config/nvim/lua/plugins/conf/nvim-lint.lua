local cspell = require("lint").linters.cspell
cspell.args = {
	"lint",
	"--no-color",
	"--no-progress",
	"--no-summary",
	"--config",
	vim.fn.expand("$XDG_CONFIG_HOME" .. "/cspell/cspell.json"),
}

require("lint").linters_by_ft = {
	dockerfile = { "hadolint" },
	zsh = { "shellcheck" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
		require("lint").try_lint({ "cspell" })
	end,
})

require("plugins.nvim-lint.cspell")
