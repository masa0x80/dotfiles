local conf = require("plugins.conf.snacks")

local M = {}

function M.open_current()
	local path = vim.fs.relpath(vim.fs.dirname(conf.git_root_or_cwd()), vim.fn.expand("%:p"))
	if not path then
		Snacks.notify.error("Not under the Obsidian vault")
		return
	end
	vim.fn.jobstart(("open 'obsidian://vault/%s'"):format(path))
end

function M.open_tmp()
	local path = ("%s/tmp.md"):format(conf.telekasten_home())
	vim.fn.execute(("tabedit %s"):format(path))
	vim.fn.jobstart(("open 'obsidian://open?path=%s'"):format(path))
end

function M.search()
	local vault = vim.fs.basename(conf.telekasten_home())
	vim.ui.input({ prompt = "Input query to search in Obsidian" }, function(input)
		local query = input
		vim.fn.jobstart(("open 'obsidian://search?vault=%s&query=%s'"):format(vault, query))
	end)
end

return M
