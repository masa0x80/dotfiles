return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{ "<C-g>\\" },
		{
			"<Leader>tf",
			function()
				vim.cmd.TermFloat({ count = vim.v.count1 })
			end,
			desc = "<v:count1>ToggleTerm direction=float",
		},
		{
			"<Leader>tb",
			function()
				vim.cmd.TermBottom({ count = vim.v.count1 })
			end,
			desc = "<v:count1>ToggleTerm direction=horizontal",
		},
	},
	init = function()
		for name, direction in pairs({ TermFloat = "float", TermBottom = "horizontal" }) do
			vim.api.nvim_create_user_command(name, function(opts)
				vim.cmd(opts.count .. "ToggleTerm direction=" .. direction)
			end, { count = true })
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
