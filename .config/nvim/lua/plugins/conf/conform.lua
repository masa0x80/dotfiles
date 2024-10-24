local formatters = {
	textlint = {
		command = "textlint",
		args = { "--fix", "$FILENAME" },
		stdin = false,
	},
	markdownlint_cli2 = {
		command = "markdownlint",
		args = { "--config", vim.fn.expand("$HOME/.config/markdownlint/.markdownlint.json"), "--fix", "$FILENAME" },
		exit_codes = { 0, 1 },
		stdin = false,
	},
}
for k, v in pairs(require("config.utils").hidden_formatters) do
	formatters[k] = v
end

vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

require("conform").setup({
	formatters_by_ft = {
		ruby = { "rubocop" },
		go = { "goimports" },
		lua = { "stylua" },
		luau = { "stylua" },
		python = { "black" },
		markdown = {
			"delete_single_space_before_japanese_punctuation_marks",
			"delete_single_space_after_japanese_punctuation_marks",
			"delete_parentheses_inside_space",
			"delete_jira_status_icon",
			"delete_no_break_spaces",
			"format_jira_link",
			"markdown_todo_format",
			"replace_ka",
			"replace_ordered_list",
			"replace_m_on_n",
			"textlint",
			"markdownlint",
			"markdown_table_formatter",
		},
		sh = { "shfmt" },
		text = { "textlint" },

		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
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
	formatters = formatters,
	format_on_save = function()
		if not vim.g.formatter_enabled then
			return
		end
		return {
			timeout_ms = 3000,
			lsp_fallback = true,
			filter = function(client)
				return client.name ~= "ts_ls"
			end,
		}
	end,
})
