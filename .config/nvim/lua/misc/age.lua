local recipient = vim.fn.getenv("AGE_RECIPIENT")
local identity = vim.fn.getenv("AGE_IDENTITY")

if recipient ~= nil and identity ~= nil then
	require("utils").create_autocmd({ "BufReadPost", "FileReadPost" }, {
		pattern = "*.age",
		callback = function()
			vim.cmd("silent '[,']!_de")
			vim.cmd("F")
		end,
	})

	require("utils").create_autocmd({ "BufWritePre", "FileWritePre" }, {
		pattern = "*.age",
		callback = function()
			local bufnr = vim.fn.bufnr()
			vim.b[bufnr].line = vim.fn.line(".") - vim.fn.line("w0")
			vim.cmd("normal! Hmz")
			vim.cmd("silent '[,']!_en")
		end,
	})

	require("utils").create_autocmd({ "BufWritePost", "FileWritePost" }, {
		pattern = "*.age",
		callback = function()
			local bufnr = vim.fn.bufnr()
			vim.cmd("silent undo")
			vim.cmd(string.format("silent! windo RestoreCursor %d", bufnr))
			vim.cmd(string.format("silent! normal! `zzt%dj", vim.b[bufnr].line))
			if vim.g.formatter_enabled then
				require("conform").format({
					async = false,
					timeout_ms = 50000,
					lsp_format = "fallback",
					range = nil,
				})
			end
		end,
	})
end
