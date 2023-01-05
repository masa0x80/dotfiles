vim.cmd([[
  function! MyStrategy(cmd)
	execute ':TermExec cmd=' .. a:cmd
  endfunction

  let g:test#custom_strategies = {
	\   'myStrategy': function('MyStrategy')
	\ }
  let g:test#strategy = 'myStrategy'
]])

local keymap = vim.keymap.set
keymap("n", ",,t", "<Cmd>TestFile<CR>", { noremap = true, silent = true, desc = "Runs all tests in the current file" })
keymap(
	"n",
	",,T",
	"<Cmd>TestNearest<CR>",
	{ noremap = true, silent = true, desc = "Runs the test nearest to the cursor" }
)
