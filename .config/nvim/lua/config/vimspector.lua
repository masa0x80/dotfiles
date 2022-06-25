vim.g.vimspector_base_dir = vim.fn.expand("$XDG_CONFIG_HOME/vimspector-config")

local function vimspector_mappings()
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_set_keymap

	keymap("n", "<Leader>db", "<Cmd>call vimspector#Launch()<CR>", opts)
	keymap("n", "<Leader>de", "<Cmd>call vimspector#Reset()<CR>", opts)
	keymap("n", "<Leader>c", "<Cmd>call vimspector#Continue()<CR>", opts)

	keymap("n", "<Leader>b", "<Cmd>call vimspector#ToggleBreakpoint()<CR>", opts)
	keymap("n", "<Leader>B", "<Cmd>call vimspector#ClearBreakpoints()<CR>", opts)

	keymap("n", "<Leader>dr", "<Plug>VimspectorRestart", {})
	keymap("n", "<Leader>k", "<Plug>VimspectorStepOut", {})
	keymap("n", "<Leader>l", "<Plug>VimspectorStepInto", {})
	keymap("n", "<Leader>j", "<Plug>VimspectorOvert", {})

	keymap("n", "<Leader>dj", "<Cmd>TestNearest -strategy=jest<CR>", {})
end

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "_",
	pattern = { "javascript", "typescript" },
	callback = vimspector_mappings,
})