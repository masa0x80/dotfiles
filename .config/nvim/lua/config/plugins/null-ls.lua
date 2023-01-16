local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

require("lsp-format").setup()
null_ls.setup({
	sources = {
		diagnostics.shellcheck,
		diagnostics.eslint.with({
			prefer_local = "node_modules/.bin",
			filetypes = { "graphql" },
		}),
		diagnostics.rubocop.with({
			prefer_local = "vendor/bin",
		}),

		formatting.stylua,
		formatting.shfmt,
		formatting.fish_indent,
		formatting.textlint.with({
			filetypes = { "text", "markdown" },
			args = {
				"-c",
				vim.fn.expand("$XDG_CONFIG_HOME" .. "/textlint/textlintrc.json"),
				"--fix",
				"$FILENAME",
			},
		}),
		formatting.rubocop.with({
			prefer_local = "vendor/bin",
		}),
		formatting.prettier.with({
			prefer_local = "node_modules/.bin",
		}),
	},
	on_attach = function(client, _)
		require("lsp-format").on_attach(client)
	end,
})