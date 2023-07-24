require("neo-tree").setup({
	use_default_mappings = false,
	popup_border_style = "rounded",
	default_component_configs = {
		git_status = {
			symbols = {
				-- Change type
				added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "✖", -- this can only be used in the git_status source
				renamed = "➜", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored = "◌",
				unstaged = "",
				staged = "",
				conflict = "",
			},
		},
		icon = {
			folder_empty = "",
			folder_empty_open = "",
		},
	},
	window = {
		mappings = {
			["u"] = "navigate_up",
			["l"] = "open",
			["<CR>"] = "open",
			["<BS>"] = "close_node",
			["h"] = "close_node",
			["H"] = "toggle_hidden",
			["s"] = "open_split",
			["-"] = "open_split",
			["v"] = "open_vsplit",
			["|"] = "open_vsplit",
			["t"] = "open_tabnew",
			["f"] = "filter_on_submit",
			["<C-]>"] = "set_root",
			["<C-c><C-c>"] = "clear_filter",
			["i"] = {
				"add",
				config = {
					show_path = "relative",
				},
			},
			["o"] = "add_directory",
			["d"] = "delete",
			["r"] = "rename",
			["c"] = "copy",
			["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
			["q"] = "close_window",
			["R"] = "refresh",
			["?"] = "show_help",
			["[g"] = "prev_git_modified",
			["]g"] = "next_git_modified",
			["C"] = "close_all_nodes",
			["yy"] = function(state)
				local node = state.tree:get_node()
				local name = node.name
				vim.fn.setreg("+", name)
				vim.fn.setreg('"', name)
				vim.notify(name, vim.log.levels.INFO, { title = "Copied" })
			end,
			["Y"] = function(state)
				local node = state.tree:get_node()
				local path = vim.fn.fnamemodify(node.path, ":.")
				vim.fn.setreg("+", path)
				vim.fn.setreg('"', path)
				vim.notify(path, vim.log.levels.INFO, { title = "Copied" })
			end,
			["<C-y>"] = function(state)
				local node = state.tree:get_node()
				local path = node.path
				vim.fn.setreg("+", path)
				vim.fn.setreg('"', path)
				vim.notify(path, vim.log.levels.INFO, { title = "Copied" })
			end,
		},
	},
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_hidden = false,
			hide_gitignored = true,
		},
		hijack_netrw_behavior = "open_current",
		follow_current_file = true,
		use_libuv_file_watcher = true,
	},
})

local keymap = vim.keymap.set
keymap("n", "-", "<Cmd>Neotree float reveal_force_cwd<CR>", { noremap = true, silent = true, desc = "NeoTree float" })
keymap(
	"n",
	"<Leader>e",
	"<Cmd>Neotree toggle left reveal_force_cwd<CR>",
	{ noremap = true, silent = true, desc = "NeoTreeFocusToggle" }
)
