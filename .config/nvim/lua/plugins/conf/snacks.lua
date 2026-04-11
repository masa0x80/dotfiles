local M = {}

M.explorer_opts = {
	hidden = true,
	ignored = true,
	win = {
		list = {
			keys = {
				["<C-l>"] = { "lcd" },
				["<C-c>"] = { "close" },
				["c"] = { { "yank_only_filename", "explorer_copy" } },
				["y"] = { "copy_file_path" },
				["Y"] = { "explorer_yank" },
				["<Leader>h"] = { "toggle_hidden" },
				["H"] = false,
				["<C-n>g"] = "explorer_git_next",
				["<C-p>g"] = "explorer_git_prev",
				["<C-n>d"] = "explorer_diagnostic_next",
				["<C-p>d"] = "explorer_diagnostic_prev",
				["<C-n>w"] = "explorer_warn_next",
				["<C-p>w"] = "explorer_warn_prev",
				["<C-n>e"] = "explorer_error_next",
				["<C-p>e"] = "explorer_error_prev",
			},
		},
	},
	actions = {
		-- NOTE: https://ricoberger.de/blog/posts/neovim-extend-snacks-nvim-explorer/
		copy_file_path = {
			action = function(_, item)
				if not item then
					return
				end

				local vals = {
					["Filename"] = vim.fn.fnamemodify(item.file, ":t"),
					["Basename"] = vim.fn.fnamemodify(item.file, ":t:r"),
					["Extension"] = vim.fn.fnamemodify(item.file, ":t:e"),
					["Path"] = item.file,
					["Path (CWD)"] = vim.fn.fnamemodify(item.file, ":."),
					["Path (HOME)"] = vim.fn.fnamemodify(item.file, ":~"),
					["URI"] = vim.uri_from_fname(item.file),
				}

				local options = vim.tbl_filter(function(val)
					return vals[val] ~= ""
				end, vim.tbl_keys(vals))
				if vim.tbl_isempty(options) then
					vim.notify("No values to copy", vim.log.levels.WARN)
					return
				end
				table.sort(options)
				vim.ui.select(options, {
					prompt = "Choose to copy to clipboard:",
					format_item = function(list_item)
						return ("%s: %s"):format(list_item, vals[list_item])
					end,
				}, function(choice)
					local result = vals[choice]
					if result then
						vim.fn.setreg("+", result)
						Snacks.notify.info("Yanked `" .. result .. "`")
					end
				end)
			end,
		},
		yank_only_filename = {
			action = function(_, item)
				if not item then
					return
				end

				local result = vim.fn.fnamemodify(item.file, ":t")
				vim.fn.setreg("+", result)
				Snacks.notify.info("Yanked `" .. result .. "`")
			end,
		},
	},
}

return M
