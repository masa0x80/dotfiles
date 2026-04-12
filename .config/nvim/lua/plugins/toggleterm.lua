return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{ "<C-\\>" },
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
		vim.api.nvim_create_user_command("TermFloat", function(opts)
			vim.fn.execute(opts.args .. "ToggleTerm direction=float")
		end, { nargs = "?" })

		vim.api.nvim_create_user_command("TermBottom", function(opts)
			vim.fn.execute(opts.args .. "ToggleTerm direction=horizontal")
		end, { nargs = "?" })
	end,
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<C-\>]],
			direction = "float",
			float_opts = {
				border = "curved",
			},
			close_on_exit = true,
		})

		local map = vim.keymap.set
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			map("t", "<Esc>", [[<C-\><C-n>]], opts)
		end

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		require("utils").create_autocmd({ "TermOpen" }, {
			pattern = "term://*",
			command = "lua set_terminal_keymaps()",
		})
	end,
}
