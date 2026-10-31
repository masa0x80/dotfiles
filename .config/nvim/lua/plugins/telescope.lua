return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		-- NOTE: telekasten.nvim のピッカーとしてのみ使う
		cmd = { "Telescope" },
		config = function()
			local actions = require("telescope.actions")
			local utils = require("utils")
			local state = require("telescope.actions.state")

			-- 選択中エントリのパスを modifier (fnamemodify の第2引数) で加工してレジスタにコピーする
			local function copy_path(modifier)
				return function()
					local path = state.get_selected_entry().path
					if modifier then
						path = vim.fn.fnamemodify(path, modifier)
					end
					vim.fn.setreg("+", path)
					vim.fn.setreg('"', path)
					vim.notify(path, vim.log.levels.INFO, { title = "Copied" })
				end
			end

			local function preview_file()
				utils.preview(state.get_selected_entry().path)
			end

			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					path_display = {
						truncate = 3,
					},
					file_ignore_patterns = { "COMMIT_EDITMSG" },
					-- add `--sortr`, `-uu` option
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--sortr=path",
						"-uu",
						"--glob=!**/*.age",
					},
					sorting_strategy = "ascending",
					layout_config = { prompt_position = "top" },
					mappings = {
						i = {
							["<C-f>"] = { "<Right>", type = "command" },
							["<C-b>"] = { "<Left>", type = "command" },
							-- ["<C-e>"] = actions.move_selection_next, -- 行末移動に使用
							["<C-y>"] = actions.move_selection_previous,
							["<C-u>"] = actions.results_scrolling_up,
							["<C-d>"] = actions.results_scrolling_down,
							["<C-k>"] = actions.preview_scrolling_up,
							["<C-j>"] = actions.preview_scrolling_down,
							["<C-c>"] = { "<Esc>", type = "command" },
							["<C-c><C-c>"] = actions.close,
							["<C-S-k>"] = preview_file,
						},
						n = {
							["<C-n>"] = actions.move_selection_next,
							["<C-p>"] = actions.move_selection_previous,
							["<C-e>"] = actions.move_selection_next,
							["<C-y>"] = actions.move_selection_previous,
							["<C-u>"] = actions.results_scrolling_up,
							["<C-d>"] = actions.results_scrolling_down,
							["<C-b>"] = actions.results_scrolling_up,
							["<C-f>"] = actions.results_scrolling_down,
							["<C-k>"] = actions.preview_scrolling_up,
							["<C-j>"] = actions.preview_scrolling_down,
							["q"] = actions.close,
							["<C-c>"] = actions.close,
							["yy"] = copy_path(":p:t"),
							["Y"] = copy_path(":."),
							["<C-S-y>"] = copy_path(),
							["K"] = preview_file,
						},
					},
				},
			})
		end,
	},
}
