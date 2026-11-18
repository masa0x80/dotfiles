local M = {}

M.foldtext = function()
	local line = vim.fn.getline(vim.v.foldstart)
	local count = vim.v.foldend - vim.v.foldstart + 1
	return string.format("%s … (%d lines folded)", line, count)
end

return M
