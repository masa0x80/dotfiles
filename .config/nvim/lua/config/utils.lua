local M = {}

M.preview = function(path)
	vim.fn.execute(string.format("!open '%s'", path))
end

M.load = function(name)
	return function()
		local path = string.format(vim.fn.expand("$HOME") .. "/.config.local/nvim/lua/plugins/%s.lua", name)
		if vim.fn.filereadable(path) == 1 then
			vim.fn.execute("luafile " .. path)
		else
			require(string.format("plugins.%s", name))
		end
	end
end

M.js_based_languages = {
	"typescript",
	"javascript",
	"typescriptreact",
	"javascriptreact",
	"vue",
}

M.hidden_formatters = {
	delete_single_space_after_japanese_punctuation_marks = {
		command = "sed",
		args = { "s|\\([。、]\\) \\(\\S\\)|\\1\\2|g" },
	},
	delete_parentheses_inside_space = {
		command = "sed",
		args = { "s|\\([(<{]\\) \\(.*\\) \\([)>}]\\)|\\1\\2\\3|g" },
	},
	delete_no_break_spaces = {
		command = "sed",
		args = { "s|[  ]| |g" },
	},
	delete_jira_status_icon = {
		command = "sed",
		args = {
			("s|\\[!\\[\\](%s.*)\\(.*\\)\\](\\(\\S*\\)) - \\([^ ]*\\) [^ ]* \\?|[\\1 \\3](\\2)|g"):format(
				vim.fn.expand("$JIRA_BASE_URL"):gsub("/browse", "")
			),
		},
	},
	format_jira_link = {
		command = "sed",
		args = { "s|\\[\\[\\(.*\\)\\] \\(.*\\)\\](\\(\\S*\\))|[\\1 \\2](\\3)|g" },
	},
	markdown_todo_format = {
		command = "sed",
		args = { "s|\\([-*+.)]\\) \\[\\]|\\1 [ ]|g" },
	},
	replace_ka = {
		command = "sed",
		args = { "s|[ヶケ]\\([月所]\\)|か\\1|g" },
	},
	replace_ordered_list = {
		command = "sed",
		args = { "s|^\\(\\s*\\)[0-9]\\+[\\.)] |\\11. |g" },
	},
	markdown_table_formatter = {
		command = "markdown-table-formatter",
		args = { "$FILENAME" },
		exit_codes = { 0, 1 },
		stdin = false,
	},
}

return M
