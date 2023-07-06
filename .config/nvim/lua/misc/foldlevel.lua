vim.api.nvim_create_user_command("FL", function(opts)
	vim.opt.foldlevel = tonumber(opts.fargs[1])
end, { nargs = 1 })
