local utils = require("config.utils")

require("neo-tree").setup({
	use_default_mappings = false,
	popup_border_style = "rounded",
	default_component_configs = {
		git_status = {
			symbols = {
				-- Change type
				added = "✚",
				modified = "",
				deleted = "✖",
				renamed = "➜",
				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
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
			["l"] = "open",
			["<CR>"] = "open",
			["<BS>"] = "close_node",
			["h"] = "close_node",
			["s"] = "open_split",
			["-"] = "open_split",
			["v"] = "open_vsplit",
			["|"] = "open_vsplit",
			["t"] = "open_tabnew",
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
			["C"] = "close_all_nodes",
			["<A-p>"] = { "toggle_preview", config = { use_float = true } },
			["<C-w><C-w>"] = "focus_preview",
			["<C-c><C-c>"] = "cancel",
			["<C-;>"] = "preview",
		},
	},
	filesystem = {
		window = {
			mappings = {
				["u"] = "navigate_up",
				["H"] = "toggle_hidden",
				["f"] = "filter_on_submit",
				["<C-]>"] = "set_root",
				["<Esc>"] = "clear_filter",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
				["yy"] = "copy_filename",
				["Y"] = "copy_relative_filename",
				["<C-y>"] = "copy_absolute_filename",
			},
		},
		commands = {
			copy_filename = function(state)
				local node = state.tree:get_node()
				local name = node.name
				vim.fn.setreg("+", name)
				vim.fn.setreg('"', name)
				vim.notify(name, vim.log.levels.INFO, { title = "Copied" })
			end,
			copy_relative_filename = function(state)
				local node = state.tree:get_node()
				local path = vim.fn.fnamemodify(node.path, ":.")
				vim.fn.setreg("+", path)
				vim.fn.setreg('"', path)
				vim.notify(path, vim.log.levels.INFO, { title = "Copied" })
			end,
			copy_absolute_filename = function(state)
				local node = state.tree:get_node()
				local path = node.path
				vim.fn.setreg("+", path)
				vim.fn.setreg('"', path)
				vim.notify(path, vim.log.levels.INFO, { title = "Copied" })
			end,
			preview = function(state)
				local node = state.tree:get_node()
				if node.type == "file" then
					utils.preview(node.path)
				end
			end,
		},
		filtered_items = {
			hide_dotfiles = false,
			hide_hidden = false,
			hide_gitignored = true,
		},
		hijack_netrw_behavior = "open_current",
		follow_current_file = {
			enabled = true,
		},
		use_libuv_file_watcher = true,
	},
	git_status = {
		window = {
			mappings = {
				["A"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
				["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			},
		},
	},
})

local keymap = vim.keymap.set
keymap("n", "-", "<Cmd>Neotree float reveal_force_cwd<CR>", { noremap = true, silent = true, desc = "NeoTree float" })
keymap(
	"n",
	"<Leader>st",
	"<Cmd>Neotree float git_status<CR>",
	{ noremap = true, silent = true, desc = "NeoTree git_status" }
)

keymap(
	"n",
	"<Leader>E",
	"<Cmd>Neotree toggle left reveal_force_cwd<CR>",
	{ noremap = true, silent = true, desc = "NeoTreeFocusToggle" }
)
