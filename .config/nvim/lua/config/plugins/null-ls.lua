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

		formatting.black,
		formatting.stylua,
		formatting.shfmt,
		formatting.fish_indent,
		formatting.terraform_fmt,
		formatting.rubocop.with({
			prefer_local = "vendor/bin",
		}),
		formatting.prettier.with({
			prefer_local = "node_modules/.bin",
		}),

		-- prettierの後にtextlintを実行したいので最後に配置する
		-- FIXME: prettierをかけると、textlintで
		-- { "ja-space-between-half-and-full-width": { "space": "never" } }
		-- と設定していても、Markdownの見出しの全角半角間にスペースが入ってしまう。
		formatting.textlint,
	},
	on_attach = function(client, _)
		require("lsp-format").on_attach(client)
	end,
})
