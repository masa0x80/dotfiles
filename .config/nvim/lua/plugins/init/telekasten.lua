vim.api.nvim_create_user_command("DeleteTodoMark", function(o)
	if o.range == 0 then
		pcall(function()
			vim.fn.execute("%s/- \\[[x -]\\] [0-9][0-9]:[0-9][0-9] - [0-9][0-9]:[0-9][0-9] /- /g")
		end)
		pcall(function()
			vim.fn.execute("%s/- \\[[x -]\\] <.*> /- /g")
		end)
		pcall(function()
			vim.fn.execute("%s/- \\[[x -]\\] /- /g")
		end)
	else
		pcall(function()
			vim.fn.execute(
				o.line1 .. "," .. o.line2 .. "s/- \\[[x -]\\] [0-9][0-9]:[0-9][0-9] - [0-9][0-9]:[0-9][0-9] /- /g"
			)
		end)
		pcall(function()
			vim.fn.execute(o.line1 .. "," .. o.line2 .. "s/- \\[[x -]\\] <.*> /- /g")
		end)
		pcall(function()
			vim.fn.execute(o.line1 .. "," .. o.line2 .. "s/- \\[[x -]\\] /- /g")
		end)
	end
	vim.fn.execute("nohlsearch")
end, {
	range = 2,
})
