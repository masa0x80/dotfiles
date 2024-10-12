local recipient = vim.fn.getenv("AGE_RECIPIENT")
local identity = vim.fn.getenv("AGE_IDENTITY")

if recipient ~= nil and identity ~= nil then
	vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
		pattern = "*.age",
		callback = function()
			if vim.bo.filetype == "age" then
				vim.cmd("F")
			end
			vim.cmd(string.format("silent '[,']!rage --decrypt -i %s", identity))
		end,
	})

	vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
		pattern = "*.age",
		callback = function()
			vim.cmd(string.format("silent '[,']!rage --encrypt -r %s -a", recipient))
		end,
	})

	vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
		pattern = "*.age",
		callback = function()
			vim.cmd("silent undo")
			require("conform").format({ async = false, lsp_format = "fallback", range = nil })
		end,
	})
end
