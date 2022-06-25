local status_ok, p = pcall(require, "neo-tree")
if not status_ok then
	return
end

p.setup({
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
	},
	window = {
		mappings = {
			["u"] = "navigate_up",
			["l"] = "open",
			["<BS>"] = "close_node",
			["h"] = "close_node",
			["s"] = "open_split",
			["-"] = "open_split",
			["v"] = "open_vsplit",
			["|"] = "open_vsplit",
			["t"] = "open_tabnew",
			["w"] = "open_with_window_picker",
			["<C-c>"] = "close_window",
			["f"] = "filter_as_you_type",
			["/"] = "filter_on_submit",
			["<C-]>"] = "set_root",
			["i"] = {
				"add",
				config = {
					show_path = "relative",
				},
			},
			["y"] = function(state)
				local node = state.tree:get_node()
				local name = node.name
				vim.fn.setreg("+", name)
				vim.fn.setreg('"', name)
				print("Copied: " .. name)
			end,
			["Y"] = function(state)
				local node = state.tree:get_node()
				local path = vim.fn.fnamemodify(node.path, ":.")
				vim.fn.setreg("+", path)
				vim.fn.setreg('"', path)
				print("Copied: " .. path)
			end,
			["gy"] = function(state)
				local node = state.tree:get_node()
				local path = node.path
				vim.fn.setreg("+", path)
				vim.fn.setreg('"', path)
				print("Copied: " .. path)
			end,
		},
	},
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_hidden = false,
			hide_gitignored = false,
		},
		-- hijack_netrw_behavior = "disabled",
		follow_current_file = true,
	},
})

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "-", "<Cmd>Neotree float reveal_force_cwd<CR>", opts)
keymap("n", "<Leader>e", "<Cmd>NeoTreeFocusToggle<CR>", opts)
