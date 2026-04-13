return {
	{
		"dinhhuy258/git.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("git").setup({
				default_mappings = false, -- NOTE: `quit_blame` and `blame_commit` are still merged to the keymaps even if `default_mappings = false`

				keymaps = {
					-- Open blame window
					blame = "<Leader>gb",
					-- Close blame window
					quit_blame = "q",
					-- Open blame commit
					blame_commit = "<CR>",
					-- Quit blame commit
					quit_blame_commit = "q",
					-- Open file/folder in git repository
					browse = "<Leader>go",
					-- Open pull request of the current branch
					open_pull_request = "<Leader>gP",
					-- Create a pull request with the target branch is set in the `target_branch` option
					create_pull_request = "<Leader>gn",
					-- Opens a new diff that compares against the current index
					diff = "<Leader>gd",
					-- Close git diff
					diff_close = "<Leader>gD",
					-- Revert to the specific commit
					revert = "<Leader>gr",
					-- Revert the current file to the specific commit
					revert_file = "<Leader>gR",
				},
				-- Default target branch when create a pull request
				target_branch = "main",
				-- Enable winbar in all windows created by this plugin
				winbar = false,
			})
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		opts = {
			highlights = { -- They must have background color, otherwise the default color will be used
				incoming = "NormalFloat",
				current = "NormalFloat",
			},
		},
		event = { "BufNewFile", "BufRead" },
	},
	{
		"rhysd/git-messenger.vim",
		version = "*",
		keys = {
			{ "<C-g><C-l>", desc = "Show Git Log" },
		},
		init = function()
			vim.g.git_messenger_always_into_popup = true
			vim.g.git_messenger_include_diff = "current"
			vim.g.git_messenger_date_format = "%F %T"
			vim.g.git_messenger_floating_win_opts = { border = "rounded" }
		end,
		config = function()
			local map = vim.keymap.set
			map("n", "<C-g><C-g><C-l>", "<Plug>(git-messenger)<CR>", { desc = "Show Git Log" })

			require("utils").create_autocmd({ "FileType" }, {
				pattern = "gitmessengerpopup",
				callback = function()
					map(
						"n",
						"<C-o>",
						"o",
						{ remap = true, buffer = true, desc = "GitMessenger: Back to older commit at the line" }
					)
					map(
						"n",
						"<C-i>",
						"O",
						{ remap = true, buffer = true, desc = "GitMessenger: Forward to newer commit at the line" }
					)
					map("n", "<C-k>", "<Up>", { remap = true, buffer = true, desc = "GitMessenger: Scroll Up" })
					map("n", "<C-j>", "<Down>", { remap = true, buffer = true, desc = "GitMessenger: Scroll Down" })
				end,
			})
		end,
	},
	{
		"ruifm/gitlinker.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			local map = vim.keymap.set
			map("n", "<Leader>gb", function()
				require("gitlinker").get_buf_range_url(
					"n",
					{ action_callback = require("gitlinker.actions").open_in_browser }
				)
			end, { silent = true, desc = "Open GitHub URL for current line in browser" })
			map("v", "<Leader>gb", function()
				require("gitlinker").get_buf_range_url(
					"v",
					{ action_callback = require("gitlinker.actions").open_in_browser }
				)
			end, { silent = true, desc = "Open GitHub URL for current selected lines in browser" })
			vim.api.nvim_create_user_command("GhBrowse", function()
				require("gitlinker").get_repo_url({ action_callback = require("gitlinker.actions").open_in_browser })
			end, {})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		version = "*",
		event = { "BufNewFile", "BufRead" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "│" },
					delete = { text = "-" },
					topdelete = { text = "-" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 0,
					ignore_whitespace = false,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]g", function()
						if vim.wo.diff then
							return "]g"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Gitsigns: next_hunk" })

					map("n", "[g", function()
						if vim.wo.diff then
							return "[g"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Gitsigns: prev_hunk" })

					-- Actions
					map({ "n", "v" }, "<C-,>gs", ":Gitsigns stage_hunk<CR>", { desc = "Gitsigns: stage_hunk" })
					map({ "n", "v" }, "<C-,>gr", ":Gitsigns reset_hunk<CR>", { desc = "Gitsigns: reset_hunk" })
					map("n", "<C-,>gu", gs.undo_stage_hunk, { desc = "Gitsigns: undo_stage_hunk" })
					map("n", "<C-,>gS", gs.stage_buffer, { desc = "Gitsigns: stage_buffer" })
					map("n", "<C-,>gR", gs.reset_buffer, { desc = "Gitsigns: reset_buffer" })
					map("n", "<C-,>gp", gs.preview_hunk, { desc = "Gitsigns: preview_hunk" })
					map("n", "<C-,>gd", gs.diffthis, { desc = "Gitsigns: diffthis" })
					map("n", "<C-,>gD", function()
						gs.diffthis("~")
					end, { desc = "Gitsigns: diffthis('~')" })
					map("n", "<C-,>gtd", gs.toggle_deleted, { desc = "Gitsigns: toggle_deleted" })
					map("n", "<C-,>gtb", gs.toggle_current_line_blame, { desc = "Gitsigns: toggle_current_line_blame" })
					map("n", "<Leader>gB", function()
						gs.blame_line({ full = true })
					end, { desc = "Gitsigns: blame_line" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<CR>", { desc = "Gitsigns: select_hunk" })
				end,
			})
		end,
	},
}
