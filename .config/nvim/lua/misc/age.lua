local recipient = vim.fn.getenv("AGE_RECIPIENT")
local identity = vim.fn.getenv("AGE_IDENTITY")

if recipient ~= nil and identity ~= nil then
	local saved_state = {}

	require("utils").create_autocmd({ "BufReadPost", "FileReadPost" }, {
		pattern = "*.age",
		callback = function()
			vim.cmd("silent %!_de")
			vim.cmd("F")
		end,
	})

	require("utils").create_autocmd({ "BufWritePre", "FileWritePre" }, {
		pattern = "*.age",
		callback = function()
			local bufnr = vim.fn.bufnr()
			local views = {}
			for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
				views[win] = vim.api.nvim_win_call(win, function()
					return vim.fn.winsaveview()
				end)
			end
			saved_state[bufnr] = {
				lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false),
				views = views,
			}
			vim.api.nvim_exec_autocmds("User", { pattern = "AgeEncryptPre", data = { bufnr = bufnr } })
			vim.cmd("silent %!_en")
		end,
	})

	require("utils").create_autocmd({ "BufWritePost", "FileWritePost" }, {
		pattern = "*.age",
		callback = function()
			local bufnr = vim.fn.bufnr()
			local state = saved_state[bufnr]
			if state then
				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, state.lines)
				for win, view in pairs(state.views) do
					vim.api.nvim_win_call(win, function()
						vim.fn.winrestview(view)
					end)
				end
				saved_state[bufnr] = nil
			else
				vim.cmd("silent undo")
			end
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
