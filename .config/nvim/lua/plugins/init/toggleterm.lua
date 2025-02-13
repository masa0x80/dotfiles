vim.api.nvim_create_user_command("TermFloat", function(opts)
	vim.fn.execute(opts.args .. "ToggleTerm direction=float")
end, { nargs = "?" })

vim.api.nvim_create_user_command("TermBottom", function(opts)
	vim.fn.execute(opts.args .. "ToggleTerm direction=horizontal")
end, { nargs = "?" })
