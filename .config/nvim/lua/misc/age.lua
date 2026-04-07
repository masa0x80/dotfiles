local recipient = vim.fn.getenv("AGE_RECIPIENT")
local identity = vim.fn.getenv("AGE_IDENTITY")

vim.g.__age_line = 0

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
			vim.g.__age_line = vim.fn.line(".") - vim.fn.line("w0")
			vim.cmd("normal! Hmz")
			vim.cmd("silent '[,']!_en")
		end,
	})

	require("utils").create_autocmd({ "BufWritePost", "FileWritePost" }, {
		pattern = "*.age",
		callback = function()
			vim.cmd("silent undo")
			vim.cmd("silent! windo RestoreCursor")
			vim.cmd(string.format("silent! normal! `zzt%sj", vim.g.__age_line))
			require("conform").format({
				async = false,
				lsp_format = "fallback",
				range = nil,
			})
		end,
	})
end
