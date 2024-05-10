return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			ruby = { "rubocop" },
			go = { "goimports" },
			lua = { "stylua" },
			luau = { "stylua" },
			python = { "black" },
			markdown = { "textlint", "markdownlint", "delete_single_space_after_japanese_punctuation_marks" },
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
			markdownlint = {
				command = "markdownlint",
				args = { "--config", "~/.config/markdownlint/config.json", "--fix", "$FILENAME" },
				exit_codes = { 0, 1 },
				stdin = false,
			},
			delete_single_space_after_japanese_punctuation_marks = {
				command = "sed",
				args = { "s|\\([。、]\\) \\(\\S\\)|\\1\\2|g" },
			},
		},
		format_on_save = function()
			if vim.env.DISABLED_FORMATTER ~= nil then
				return
			end
			return {
				timeout_ms = 3000,
				lsp_fallback = true,
			}
		end,
	},
	event = "VeryLazy",
}
