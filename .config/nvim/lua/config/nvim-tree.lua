local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

vim.g.nvim_tree_icons = {
	default = "",
	symlink = "",
	git = {
		unstaged = "",
		staged = "",
		unmerged = "",
		renamed = "➜",
		untracked = "",
		deleted = "",
		ignored = "◌",
	},
	folder = {
		arrow_open = "",
		arrow_closed = "",
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = "",
		symlink_open = "",
	},
}

nvim_tree.setup({ -- BEGIN_DEFAULT_OPTS
	auto_reload_on_write = true,
	disable_netrw = true,
	hijack_cursor = true,
	hijack_netrw = true,
	open_on_setup = true,
	view = {
		width = 30,
		mappings = {
			custom_only = true,
			list = {
				-- Default Mappings
				-- { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
				{ key = "<C-e>", action = "edit_in_place" },
				{ key = { "O" }, action = "edit_no_picker" },
				{ key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
				{ key = "<C-v>", action = "vsplit" },
				{ key = "<C-x>", action = "split" },
				{ key = "<C-t>", action = "tabnew" },
				{ key = "<", action = "prev_sibling" },
				{ key = ">", action = "next_sibling" },
				{ key = "P", action = "parent_node" },
				-- { key = "<BS>",                         action = "close_node" },
				{ key = "<Tab>", action = "preview" },
				{ key = "K", action = "first_sibling" },
				{ key = "J", action = "last_sibling" },
				{ key = "I", action = "toggle_git_ignored" },
				{ key = "H", action = "toggle_dotfiles" },
				{ key = "R", action = "refresh" },
				-- { key = "a", action = "create" },
				{ key = "d", action = "remove" },
				{ key = "D", action = "trash" },
				{ key = "r", action = "rename" },
				{ key = "<C-r>", action = "full_rename" },
				{ key = "x", action = "cut" },
				{ key = "c", action = "copy" },
				{ key = "p", action = "paste" },
				{ key = "y", action = "copy_name" },
				{ key = "Y", action = "copy_path" },
				{ key = "gy", action = "copy_absolute_path" },
				-- { key = "[c",                           action = "prev_git_item" },
				-- { key = "]c",                           action = "next_git_item" },
				{ key = "-", action = "dir_up" },
				{ key = "s", action = "system_open" },
				-- { key = "f", action = "live_filter" },
				-- { key = "F", action = "clear_live_filter" },
				{ key = "q", action = "close" },
				-- { key = "g?", action = "toggle_help" },
				-- { key = "W",                            action = "collapse_all" },
				-- { key = "S",                            action = "search_node" },
				{ key = "<C-k>", action = "toggle_file_info" },
				{ key = ".", action = "run_file_command" },

				-- Custom Mappings
				{ key = { "<CR>", "o", "l" }, action = "edit" },
				{ key = { "<BS>", "h" }, action = "close_node" },
				{ key = "i", action = "create" },
				{ key = "[g", action = "prev_git_item" },
				{ key = "]g", action = "next_git_item" },
				{ key = "z", action = "collapse_all" },
				{ key = "?", action = "toggle_help" },
				{ key = "/", action = "live_filter" },
				{ key = "<C-x>", action = "clear_live_filter" },
			},
		},
	},
	renderer = {
		indent_markers = {
			enable = false,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
		},
	},
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	filters = {
		dotfiles = false,
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 400,
	},
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = false,
			global = false,
			restrict_above_cwd = false,
		},
	},
	trash = {
		cmd = "rm -rf",
		require_confirm = true,
	},
})

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<Leader>e", "<Cmd>NvimTreeToggle<CR>", opts)
