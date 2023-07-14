local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

require("lsp-format").setup()
null_ls.setup({
	sources = {
		diagnostics.shellcheck,
		diagnostics.hadolint.with({
			args = { "--no-fail", "--format=json", "-", "--ignore", "DL3008" },
		}),
		diagnostics.rubocop.with({
			prefer_local = "vendor/bin",
		}),
		diagnostics.terraform_validate,
		diagnostics.cspell.with({
			diagnostics_postprocess = function(diagnostic)
				-- Change severity (Default: ERROR)
				diagnostic.severity = vim.diagnostic.severity["HINT"]
			end,
			condition = function()
				return vim.fn.executable("cspell") > 0
			end,
			config = {
				find_json = function()
					return vim.fn.expand("~/.config/cspell.json")
				end,
			},
		}),

		formatting.black,
		formatting.stylua,
		formatting.shfmt,
		formatting.fish_indent,
		formatting.terraform_fmt,
		formatting.textlint,
		formatting.markdownlint,
		formatting.rubocop.with({
			prefer_local = "vendor/bin",
		}),
		formatting.prettier.with({
			prefer_local = "node_modules/.bin",
			disabled_filetypes = { "markdown" },
		}),
	},
	on_attach = function(client, _)
		require("lsp-format").on_attach(client)
	end,
})
