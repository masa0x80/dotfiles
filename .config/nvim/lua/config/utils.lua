local M = {}

M.preview = function(path)
	local ext = path:match("^.+%.(.+)$")
	if vim.tbl_contains({ "bmp", "jpg", "jpeg", "png", "gif", "ico" }, string.lower(ext)) then
		if os.getenv("TMUX") == nil then
			vim.fn.execute(
				string.format(
					'!wezterm cli spawn --new-window -- zsh -c \'wezterm imgcat "%s"; echo "%s";  read\'',
					path,
					path
				)
			)
		else
			vim.fn.execute(
				string.format('!tmux popup \'bat --style="numbers,changes,header,grid" "%s"; read\'', path, path)
			)
		end
	else
		vim.fn.execute(string.format("!open '%s'", path))
	end
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
}

return M
