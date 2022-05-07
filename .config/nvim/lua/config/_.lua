vim.cmd([[
  filetype plugin indent on
  syntax on
]])

vim.api.nvim_create_augroup("_", { clear = true })

-- ref. `:help restore-cursor`
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	group = "_",
	pattern = "*",
	command = [[
    if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$")
      execute 'normal! g`"'
    endif
  ]],
})
