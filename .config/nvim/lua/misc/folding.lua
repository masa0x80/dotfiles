vim.api.nvim_create_user_command("FL", function(opts)
	vim.opt.foldlevel = tonumber(opts.fargs[1])
end, { nargs = 1 })
vim.api.nvim_create_user_command("FoldLevel", function(opts)
	vim.opt.foldlevel = tonumber(opts.fargs[1])
end, { nargs = 1 })

local complete_list = {
	"expr",
	"marker",
}
vim.api.nvim_create_user_command("FM", function(opts)
	vim.opt.foldmethod = opts.fargs[1]
end, {
	nargs = 1,
	complete = function(_, _, _)
		return complete_list
	end,
})
vim.api.nvim_create_user_command("FoldMethod", function(opts)
	vim.opt.foldmethod = opts.fargs[1]
end, {
	nargs = 1,
	complete = function(_, _, _)
		return complete_list
	end,
})
