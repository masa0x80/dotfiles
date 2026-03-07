local lint = require("lint")
local cspell = lint.linters.cspell
cspell.args = {
	"lint",
	"--no-color",
	"--no-progress",
	"--no-summary",
	"--config",
	vim.fn.expand("$XDG_CONFIG_HOME" .. "/cspell/cspell.json"),
}

lint.linters.textlint = {
	cmd = "textlint",
	args = {
		"-c",
		vim.fn.expand("$XDG_CONFIG_HOME" .. "/textlint/textlintrc.yaml"),
		"--format",
		"json",
		"--stdin",
		"--stdin-filename",
		function()
			return vim.api.nvim_buf_get_name(0)
		end,
	},
	stdin = true,
	ignore_exitcode = true,
	parser = function(output, bufnr)
		local diagnostics = {}
		local ok, decoded = pcall(vim.json.decode, output)
		if not ok or not decoded then
			return diagnostics
		end

		for _, file in ipairs(decoded) do
			for _, msg in ipairs(file.messages) do
				table.insert(diagnostics, {
					lnum = msg.line - 1,
					col = msg.column - 1,
					message = msg.message,
					severity = msg.severity == 2 and vim.diagnostic.severity.WARN or vim.diagnostic.severity.ERROR,
					source = "textlint",
				})
			end
		end

		return diagnostics
	end,
}

lint.linters_by_ft = {
	["yaml.ghaction"] = { "actionlint" },
	dockerfile = { "hadolint" },
	zsh = { "shellcheck" },
}

require("utils").create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
		require("lint").try_lint({ "cspell" })
		require("lint").try_lint({ "textlint" })
	end,
})

require("plugins.nvim-lint.cspell")
