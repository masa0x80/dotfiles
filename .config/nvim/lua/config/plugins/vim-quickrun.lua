vim.g.quickrun_no_default_key_mappings = 1
vim.g.quickrun_config = {
	_ = {
		["outputter/buffer/close_on_empty"] = 1,
		["outputter/buffer/into"] = 0,
		["outputter/buffer/opener"] = "5new",
		runner = "neovim_job",
	},
	plantuml = {
		exec = "PlantUmlPreview",
		runner = "vimscript",
	},
	rspec = {
		command = "rspec",
		cmdopt = "-f p",
		exec = "bundle exec %c %o %s",
		filetype = "rspec-result",
	},
	rspec_line = {
		command = "rspec",
		exec = "bundle exec %c %s:%a",
		filetype = "rspec-result",
	},
	typescript = {
		command = "node",
	},
}

local keymap = vim.keymap.set
vim.api.nvim_create_autocmd({ "UIEnter" }, {
	group = "_",
	pattern = "*",
	callback = function()
		if string.match(vim.fn.expand("%"), "_spec.rb$") == "_spec.rb" then
			vim.b.quickrun_config = { type = "rspec" }
			keymap(
				"n",
				"<Leader>x",
				"<Cmd>QuickRun rspec_line -args " .. vim.fn.line(".") .. "<CR>",
				{ noremap = true, silent = true, desc = "QuickRun" }
			)
			keymap(
				"n",
				"<Leader>X",
				"<Cmd>!echo wating...<CR>:QuickRun<CR>",
				{ noremap = true, silent = true, desc = "QuickRun" }
			)
		else
			keymap(
				"n",
				"<Leader>x",
				"<Cmd>!echo wating...<CR>:QuickRun<CR>",
				{ noremap = true, silent = true, desc = "QuickRun" }
			)
		end
	end,
})
