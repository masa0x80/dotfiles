vim.cmd([[
  function! MyStrategy(cmd)
	execute ':TermExec cmd=' .. a:cmd
  endfunction

  function! JestStrategy(cmd)
	let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
	call vimspector#LaunchWithSettings( #{ configuration: 'jest', TestName: testName } )
  endfunction

  let g:test#custom_strategies = {
	\   'myStrategy': function('MyStrategy'),
	\   'jest': function('JestStrategy')
	\ }
  let g:test#strategy = 'myStrategy'
]])

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<Leader>t", "<Cmd>TestFile<CR>", opts)
keymap("n", "<Leader>T", "<Cmd>TestNearest<CR>", opts)
