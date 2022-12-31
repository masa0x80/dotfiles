vim.g.vimspector_base_dir = vim.fn.expand("$XDG_CONFIG_HOME/vimspector-config")

local function vimspector_mappings()
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_set_keymap

	keymap("n", ",dd", "<Cmd>call vimspector#Launch()<CR>", opts)
	keymap("n", ",de", "<Cmd>call vimspector#Reset()<CR>", opts)
	keymap("n", ",dr", "<Plug>VimspectorRestart", {})
	keymap("n", ",c", "<Cmd>call vimspector#Continue()<CR>", opts)

	keymap("n", ",b", "<Cmd>call vimspector#ToggleBreakpoint()<CR>", opts)
	keymap("n", ",B", "<Cmd>call vimspector#ClearBreakpoints()<CR>", opts)

	keymap("n", ",k", "<Plug>VimspectorStepOut", {})
	keymap("n", ",l", "<Plug>VimspectorStepInto", {})
	keymap("n", ",j", "<Plug>VimspectorOvert", {})
end

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "_",
	pattern = { "javascript", "typescript" },
	callback = vimspector_mappings,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "_",
	pattern = { "javascript", "typescript" },
	callback = function()
		local keymap = vim.api.nvim_set_keymap
		keymap("n", ",dj", "<Cmd>TestNearest -strategy=jest<CR>", {})
	end,
})
