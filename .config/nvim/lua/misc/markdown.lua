if vim.fn.executable("markdown2confluence") == 1 then
	vim.api.nvim_create_user_command("Md2Confluence", function()
		local out = "/tmp/" .. vim.fn.strftime("%FT%T") .. ".confluence"
		vim.fn.execute("%y")
		vim.fn.execute("edit " .. out)
		vim.fn.execute("put!")
		vim.fn.execute("write")
		vim.fn.execute("0read !cat " .. out .. " | markdown2confluence")
		vim.fn.execute((vim.fn.line(".") + 1) .. ",$d")
		vim.fn.execute("%y")
	end, {})
end
