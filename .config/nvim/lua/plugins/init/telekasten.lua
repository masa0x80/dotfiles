vim.api.nvim_create_user_command("DeleteTodoMark", function(o)
	if o.range == 0 then
		vim.fn.execute("%s/\\[[x ]\\] //g")
	else
		vim.fn.execute(o.line1 .. "," .. o.line2 .. "s/- \\[[x -]\\] /- /g")
	end
	vim.fn.execute("nohlsearch")
end, {
	range = 2,
})

vim.api.nvim_create_user_command("OpenObsidian", function()
	local vault_path = require("telekasten").Cfg.home
	local path = vim.fn.shellescape(vim.fn.expand("%"):gsub(vault_path .. "/", ""))
	local vault = vault_path:gsub(".*/", "")
	vim.fn.execute("!open 'obsidian://open?vault=" .. vault .. "&file=" .. path .. "'")
end, {})
