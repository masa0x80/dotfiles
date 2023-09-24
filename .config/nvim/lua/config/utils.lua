local M = {}

M.preview = function(path)
	local ext = path:match("^.+%.(.+)$")
	local List = require("plenary.collections.py_list")
	if List({ "bmp", "jpg", "jpeg", "png", "gif", "ico" }):contains(string.lower(ext)) then
		vim.fn.execute(
			string.format(
				'!wezterm cli spawn --new-window -- zsh -c \'wezterm imgcat "%s"; echo "%s";  read\'',
				path,
				path
			)
		)
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
		vim.fn.execute(
			string.format(
				'!wezterm cli spawn --new-window -- zsh -c \'bat --style="numbers,changes,header,grid" "%s"; read\'',
				path,
				path
			)
		)
	end
end

return M
