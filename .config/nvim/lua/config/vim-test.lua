local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<Leader>t", "<Cmd>TestNearest<CR>", opts)
keymap("n", "<Leader>T", "<Cmd>TestFile<CR>", opts)

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	group = "_",
	callback = function()
		vim.cmd([[
      function! MyNeoVimStrategy(cmd)
        let term_position = get(g:, 'test#neovim#term_position', 'botright')
        execute term_position . ' new'
        call termopen(a:cmd)
      endfunction

      function! JestStrategy(cmd)
        let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
        call vimspector#LaunchWithSettings( #{ configuration: 'jest', TestName: testName } )
      endfunction

      let g:test#custom_strategies = {
        \   'myneovim': function('MyNeoVimStrategy'),
        \   'jest': function('JestStrategy')
        \ }
      let g:test#strategy = 'myneovim'
    ]])
	end,
})
