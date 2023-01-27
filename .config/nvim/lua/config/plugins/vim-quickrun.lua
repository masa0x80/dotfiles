vim.g.quickrun_no_default_key_mappings = 1
vim.g.quickrun_config = {
	_ = {
		["outputter/buffer/close_on_empty"] = 1,
		["outputter/buffer/into"] = 0,
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
		cmdopt = "-f p",
		exec = "bundle exec %c %o %s:%a",
		filetype = "rspec-result",
	},
	typescript = {
		command = "node",
	},
	jest = {
		command = "node_modules/.bin/jest",
		filetype = "jest-result",
	},
	jest_line = {
		command = "node_modules/.bin/jest",
		exec = "%c %s --testNamePattern=\"\\$(head -n %a src/app.controller.spec.ts | tac | rg -o '(it\\(|describe\\().(.*).,' --replace '\\$2' | head -n1)\"",
		filetype = "jest-result",
	},
}

local keymap = vim.keymap.set
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	group = "_",
	pattern = "*",
	callback = function()
		if string.match(vim.fn.expand("%"), "_spec.rb$") then
			vim.b.quickrun_config = { type = "rspec" }
			keymap("n", ",x", function()
				vim.cmd("QuickRun rspec_line -args " .. vim.fn.line("."))
			end, { noremap = true, silent = true, buffer = true, desc = "QuickRun" })
			keymap("n", ",,x", function()
				vim.cmd("echo 'waiting...'")
				vim.cmd("QuickRun")
			end, { noremap = true, silent = true, buffer = true, desc = "QuickRun" })
		elseif string.match(vim.fn.expand("%"), "spec.ts$") or string.match(vim.fn.expand("%"), "test.ts$") then
			vim.b.quickrun_config = { type = "jest" }
			keymap("n", ",x", function()
				vim.cmd("QuickRun jest_line -args " .. vim.fn.line("."))
			end, { noremap = true, silent = true, buffer = true, desc = "QuickRun" })
			keymap("n", ",,x", function()
				vim.cmd("echo 'waiting...'")
				vim.cmd("QuickRun")
			end, { noremap = true, silent = true, buffer = true, desc = "QuickRun" })
		else
			keymap("n", ",x", function()
				vim.cmd("QuickRun")
			end, { noremap = true, silent = true, buffer = true, desc = "QuickRun" })
		end
	end,
})
