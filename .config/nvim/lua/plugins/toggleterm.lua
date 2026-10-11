return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{ "<C-g>\\" },
		{
			"<Leader>tf",
			"<Cmd>TermFloat<CR>",
			desc = "<v:count1>ToggleTerm direction=float",
		},
		{
			"<Leader>tb",
			"<Cmd>TermBottom<CR>",
			desc = "<v:count1>ToggleTerm direction=horizontal",
		},
	},
	init = function()
		for name, direction in pairs({ TermFloat = "float", TermBottom = "horizontal" }) do
			vim.api.nvim_create_user_command(name, function(opts)
				vim.cmd(opts.args .. "ToggleTerm direction=" .. direction)
			end, { nargs = "?" })
		end
	end,
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<C-g>\]],
			direction = "float",
			float_opts = {
				border = "curved",
			},
			close_on_exit = true,
		})

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		require("utils").create_autocmd({ "TermOpen" }, {
			pattern = "term://*",
			callback = function(args)
				vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = args.buf })
			end,
		})
	end,
}
