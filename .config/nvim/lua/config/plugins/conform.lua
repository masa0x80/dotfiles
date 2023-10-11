require("conform").setup({
	formatters_by_ft = {
		go = { "goimports" },
		lua = { "stylua" },
		luau = { "stylua" },
		python = { "black" },
		markdown = { "textlint", "markdownlint" },
		sh = { "shfmt" },
		text = { "textlint" },

		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescripttypescript = { "prettier" },
		typescriptreact = { "prettier" },
		vue = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		less = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		yaml = { "prettier" },
		graphql = { "prettier" },
	},
	formatters = {
		textlint = {
			command = "textlint",
			args = { "--fix", "$FILENAME" },
			stdin = false,
		},
	},
	format_on_save = {
		timeout_ms = 3000,
		lsp_fallback = true,
	},
})
