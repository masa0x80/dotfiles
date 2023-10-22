vim.api.nvim_create_user_command("DeleteTodoMark", function(o)
	if o.range == 0 then
		vim.fn.execute("%s/\\[[x ]\\] //g")
	else
		vim.fn.execute(o.line1 .. "," .. o.line2 .. "s/\\[[x ]\\] //g")
	end
	vim.fn.execute("nohlsearch")
end, {
	range = 2,
})
