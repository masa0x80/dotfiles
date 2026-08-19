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
				end, {
					"Path (CWD)",
					"Path (HOME)",
					"Path",
					"Filename",
					"Basename",
					"Extension",
					"URI",
				})
				if vim.tbl_isempty(options) then
					vim.notify("No values to copy", vim.log.levels.WARN)
					return
				end
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

M.git_root_or_cwd = function()
	return require("snacks.git").get_root() or vim.fn.getcwd()
end

M.dir_prompt = function(default, cb)
	default = default or vim.fn.getcwd()
	vim.ui.input({
		prompt = "Directory: ",
		default = vim.fn.fnamemodify(default, ":~") .. "/",
		completion = "dir",
	}, function(input)
		if input == nil or vim.trim(input) == "" then
			return
		end
		local dir = vim.fn.expand(vim.trim(input))
		if vim.fn.isdirectory(dir) == 0 then
			Snacks.notify.error("Not a directory: `" .. dir .. "`")
			return
		end
		cb(vim.fs.normalize(vim.fn.fnamemodify(dir, ":p")))
	end)
end

-- Git管理化ならgit_files、そうでなければfilesを使う
-- @param opts? table additional options (cwd, sort, etc.)
M.smart_files = function(opts)
	opts = opts or {}
	local root = require("snacks.git").get_root()
	if root == nil then
		Snacks.picker.files(vim.tbl_deep_extend("force", {
			hidden = true,
			ignored = true,
		}, opts))
	else
		Snacks.picker.git_files(vim.tbl_deep_extend("force", {
			untracked = true,
		}, opts))
	end
end

return M
