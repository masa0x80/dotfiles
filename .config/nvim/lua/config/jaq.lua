local status_ok, p = pcall(require, "jaq-nvim")
if not status_ok then
	return
end

p.setup({
	cmds = {
		default = "toggleterm",
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
	ui = {
		toggleterm = {
			position = "float",
		},
	},
})

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<Leader>x", "<Cmd>Jaq<CR>", opts)
