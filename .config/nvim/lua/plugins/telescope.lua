local UNORDERED_LIST_PATTERN = "^%s*[-*+] $"
local TASK_PATTERN = "^%s*[-*+] %[[x ]%] $"

return {
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
		{ "<Leader>g", "<Cmd>Telescope kensaku<CR>", desc = "Search by [G]rep" },
		{ "<Leader>G", "<Cmd>lua require('telescope.builtin').grep_string()<CR>", desc = "[G] Search current Word" },
		{ "<Leader>sd", "<Cmd>lua require('telescope.builtin').diagnostics()<CR>", desc = "[S]earch [D]iagnostics" },
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
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
		"nvim-telescope/telescope-ghq.nvim",
		"nvim-telescope/telescope-dap.nvim",
		{
			"renerocksai/telekasten.nvim",
			keys = {
				{ ";z", "<Cmd>Telekasten panel<CR>", noremap = true, silent = true },
				{ ";i", "<Cmd>Telekasten insert_link<CR>", noremap = true, silent = true },
				{ ";I", "<Cmd>Telekasten insert_img_link<CR>", noremap = true, silent = true },
				{ "g]", "<Cmd>Telekasten follow_link<CR>", noremap = true, silent = true },
				{ "g[", "<Cmd>Telekasten show_backlinks<CR>", noremap = true, silent = true },
				{ ";n", "<Cmd>Telekasten new_note<CR>", noremap = true, silent = true },
				{ ";r", "<Cmd>Telekasten find_friends<CR>", noremap = true, silent = true },
				{ ";t", "<Cmd>Telekasten show_tags<CR>", noremap = true, silent = true },
				{
					"<C-g><C-i>",
					function()
						local row = vim.fn.line(".") - 1
						local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

						if string.match(line, string.sub(TASK_PATTERN, 0, -2)) then
							require("telekasten").toggle_todo()
							return
						elseif string.match(line, string.sub(UNORDERED_LIST_PATTERN, 0, -2)) then
							new = line:gsub("[-*+] (%S)", "%1", 1)
						else
							new = line:gsub("(%S)", "- %1", 1)
						end
						vim.api.nvim_buf_set_lines(0, row, row + 1, false, { new })
					end,
					noremap = true,
					silent = true,
					mode = { "n", "i" },
				},
				{
					"<C-g><C-g><C-i>",
					"<Esc><Cmd>lua require('telekasten').toggle_todo({ i = true })<CR>",
					noremap = true,
					silent = true,
					mode = "i",
				},
				{
					"<C-g><C-g><C-i>",
					"<Cmd>lua require('telekasten').toggle_todo()<CR>",
					noremap = true,
					silent = true,
				},
				{ ";d", "<Cmd>Telekasten goto_today<CR>", noremap = true, silent = true },
				{ ";w", "<Cmd>Telekasten goto_thisweek<CR>", noremap = true, silent = true },
				{ ";c", "<Cmd>Telekasten show_calendar<CR>", noremap = true, silent = true },
				{
					";f",
					"<Cmd>lua require('telescope.builtin').find_files({ cwd = require('telekasten').Cfg.home })<CR>",
					noremap = true,
					silent = true,
				},
				{
					";g",
					"<Cmd>lua require('telescope._extensions.kensaku').exports.kensaku({ cwd = require('telekasten').Cfg.home })<CR>",
					noremap = true,
					silent = true,
				},
				{ ";v", "<Cmd>Telekasten switch_vault<CR>", noremap = true, silent = true },
				{ ";o", "<Cmd>OpenObsidian<CR>", noremap = true, silent = true },
			},
			config = require("config.utils").load("conf/telekasten"),
			init = require("config.utils").load("init/telekasten"),
			dependencies = {
				{
					"renerocksai/calendar-vim",
					"Allianaab2m/telescope-kensaku.nvim",
				},
			},
		},
	},
}
