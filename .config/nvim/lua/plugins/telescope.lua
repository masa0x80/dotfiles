return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{
				"<Leader>b",
				"<Cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<CR>",
				desc = "Find existing [B]uffers",
			},
			{
				"<Leader>/",
				"<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({ winblend = 10, previewer = false }))<CR>",
				desc = "[/] Fuzzily search in current buffer]",
			},
			{
				"<Leader>f",
				function()
					vim.fn.system("git rev-parse --is-inside-work-tree")
					if vim.v.shell_error == 0 then
						require("telescope.builtin").git_files({ hidden = true })
					else
						require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
					end
				end,
				desc = "Search [F]iles",
			},
			{
				"<Leader>F",
				"<Cmd>lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true })<CR>",
				desc = "Search [F]iles",
			},
			{ "<Leader>sh", "<Cmd>lua require('telescope.builtin').help_tags()<CR>", desc = "[S]earch [H]elp" },
			{ "<Leader>g", "<Cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Search by [G]rep" },
			{
				"<Leader>G",
				"<Cmd>lua require('telescope.builtin').grep_string()<CR>",
				desc = "[G] Search current Word",
			},
			{ "<Leader>k", "<Cmd>Telescope kensaku<CR>", desc = "Search by [K]ensaku" },
			{
				"<Leader>sd",
				"<Cmd>lua require('telescope.builtin').diagnostics()<CR>",
				desc = "[S]earch [D]iagnostics",
			},
			{
				"<Leader>e",
				"<Cmd>lua require('telescope.builtin').oldfiles()<CR>",
				desc = "Find r[e]cently opened files",
			},
			{ "<Leader>?", "<Cmd>lua require('telescope.builtin').keymaps()<CR>", desc = "[?] Search Keymaps" },
			{ "<Leader>tt", "<Cmd>lua require('telescope.builtin').resume()<CR>", desc = "Telescope Resume" },

			{ "<Leader>;", "<Cmd>lua require('telescope.builtin').commands()<CR>", desc = "[;] Search Commands" },
			{
				"<Leader>:",
				"<Cmd>lua require('telescope.builtin').command_history()<CR>",
				desc = "[:] Search Command History",
			},

			{
				";e",
				"<Cmd>lua require('telescope._extensions.ghq_builtin').list()<CR>",
				desc = "Telescope ghq list",
			},
		},
		config = require("config.utils").load("conf/telescope"),
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-telescope/telescope-ghq.nvim",
	},
	{
		"nvim-telescope/telescope-dap.nvim",
	},
	{
		"Allianaab2m/telescope-kensaku.nvim",
	},
}
