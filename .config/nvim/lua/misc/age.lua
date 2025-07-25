local recipient = vim.fn.getenv("AGE_RECIPIENT")
local identity = vim.fn.getenv("AGE_IDENTITY")

if recipient ~= nil and identity ~= nil then
	vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
		pattern = "*.age",
		callback = function()
			vim.cmd(string.format("silent '[,']!rage --decrypt -i %s", identity))
			vim.cmd("F")
		end,
	})

	vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
		pattern = "*.age",
		callback = function()
			vim.cmd("normal! mm")
			vim.cmd("normal! Hmt")
			vim.cmd(string.format("silent '[,']!rage --encrypt -r %s -a", recipient))
		end,
	})

	vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
		pattern = "*.age",
		callback = function()
			vim.cmd("silent undo")
			require("conform").format({ async = false, lsp_format = "fallback", range = nil })
			vim.cmd("normal! `tzt")
			vim.cmd("normal! `m")
		end,
	})
end
