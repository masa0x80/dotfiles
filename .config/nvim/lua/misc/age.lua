local recipient = vim.fn.getenv("AGE_RECIPIENT")
local identity = vim.fn.getenv("AGE_IDENTITY")

if recipient ~= nil and identity ~= nil then
	vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
		pattern = "*.age",
		callback = function()
			local ft = string.match(vim.fn.expand("%:t"), "%.(%w+).age")
			if ft ~= nil then
				if ft == "md" then
					vim.bo.filetype = "markdown"
				else
					vim.bo.filetype = ft
				end
			else
				vim.bo.filetype = "age"
			end
			vim.cmd(string.format("silent '[,']!rage --decrypt -i %s", identity))
		end,
	})

	vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
		pattern = "*.age",
		command = string.format("silent '[,']!rage --encrypt -r %s -a", recipient),
	})

	vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
		pattern = "*.age",
		command = "silent undo",
	})
end
