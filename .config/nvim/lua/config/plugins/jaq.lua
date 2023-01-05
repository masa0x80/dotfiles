require("jaq-nvim").setup({
	cmds = {
		external = {
			typescript = "node %",
			javascript = "node %",
			markdown = "glow %",
			python = "python3 %",
			rust = "rustc % && ./$fileBase && rm $fileBase",
			cpp = "g++ % -o $fileBase && ./$fileBase",
			go = "go run %",
			sh = "sh %",
			ruby = "ruby %",
			rspec = "rspec %",
		},
	},
	behavior = {
		default = "quickfix",
	},
	ui = {
		terminal = {
			position = "bot",
			size = 10,
			line_no = false,
		},
	},
})

vim.keymap.set("n", ",x", "<Cmd>Jaq<CR><C-w>k", { noremap = true, silent = true, desc = "QuickRun" })
