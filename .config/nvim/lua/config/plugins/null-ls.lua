local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

require("lsp-format").setup()
null_ls.setup({
	sources = {
		diagnostics.rubocop.with({
			prefer_local = "vendor/bin",
		}),
		diagnostics.terraform_validate,

		formatting.rubocop.with({
			prefer_local = "vendor/bin",
		}),
	},
	on_attach = function(client, _)
		require("lsp-format").on_attach(client)
	end,
})
