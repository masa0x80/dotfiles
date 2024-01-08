local M = {}

M.preview = function(path)
	local ext = path:match("^.+%.(.+)$")
	local List = require("plenary.collections.py_list")
	if List({ "bmp", "jpg", "jpeg", "png", "gif", "ico" }):contains(string.lower(ext)) then
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
	elseif
		List({
			"svg",
			"webp",
			"heic",
			"avif",

			"avi",
			"mp4",
			"wmv",
			"dat",
			"3gp",
			"ogv",
			"mkv",
			"mpg",
			"mpeg",
			"vob",
			"m2v",
			"mov",
			"webm",
			"mts",
			"m4v",
			"rm",
			"qt",
			"divx",

			"pdf",
			"epub",
		}):contains(string.lower(ext))
	then
		vim.fn.execute(string.format("!open '%s'", path))
	else
		if os.getenv("TMUX") == nil then
			vim.fn.execute(
				string.format(
					'!wezterm cli spawn --new-window -- zsh -c \'bat --style="numbers,changes,header,grid" "%s"; read\'',
					path,
					path
				)
			)
		else
			vim.fn.execute(
				string.format('!tmux popup \'bat --style="numbers,changes,header,grid" "%s"; read\'', path, path)
			)
		end
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

return M
