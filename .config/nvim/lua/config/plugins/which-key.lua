local status_ok, p = pcall(require, "which-key")
if not status_ok then
	return
end

p.setup({
	triggers_blacklist = {
		n = { ";" },
	},
})

p.register({
	-- BackAndForward
	["<C-o>"] = "BackAndForward Back",
	["<C-i>"] = "BackAndForward Forward",
	-- git-messenger
	["<C-l>"] = "Show git log",
}, {
	mode = "n",
	prefix = "<C-g>",
})

-- keymaps
p.register({
	["<C-h>"] = "backward-word",
	["<C-l>"] = "forward-word",
	["<C-n>"] = "Indent >>>",
	["<C-p>"] = "Indent <<<",
}, {
	mode = "i",
	prefix = "<C-g>",
})

-- cmp
p.register({
	["<C-l>"] = "Whole lines",
	["<C-n>"] = "keywords in the current file",
	["<C-k>"] = "keywords in dictionary",
	["<C-t>"] = "keywords in thesaurus",
	["<C-i>"] = "keywords in the current and included files",
	["<C-]>"] = "tags",
	["<C-f>"] = "file names",
	["<C-d>"] = "definitions or macros",
	["<C-v>"] = "Vim command-line",
	["<C-u>"] = "User defined completion",
	["<C-o>"] = "omni completion",
	["<C-s>"] = "Spelling suggestions",
	["<C-z>"] = "stop completion",
	["<C-x>"] = "cmp spell",
}, {
	mode = "i",
	prefix = "<C-x>",
})

-- Commentout
p.register({
	["<C-_>"] = "Toggle line-comment",
	["<C-b>"] = "Toggle block-comment",
}, {
	mode = "n",
	prefix = "<C-_>",
})
p.register({
	["<C-_>"] = "Toggle line-comment",
	["<C-b>"] = "Toggle block-comment",
}, {
	mode = "v",
	prefix = "<C-_>",
})

-- Gitsigns
p.register({
	["b"] = "Gitsigns blame_line",
	["D"] = "Gitsigns diffthis('~')",
	["d"] = "Gitsigns diffthis",
	["p"] = "Gitsigns preview_hunk",
	["R"] = "Gitsigns reset_buffer",
	["S"] = "Gitsigns stage_buffer",
	["u"] = "Gitsigns undo_stage_hunk",
	-- ToggleTerm
	["f"] = "<v:count1>ToggleTerm direction=float",
	["j"] = "<v:count1>ToggleTerm direction=horizontal",
	t = {
		["d"] = "Gitsigns toggle_deleted",
		["b"] = "Gitsigns toggle_current_line_blame",
	},
}, {
	mode = "n",
	prefix = ",,",
})
p.register({
	["g"] = "Gitsigns next_hunk",
}, {
	mode = "n",
	prefix = "]",
})
p.register({
	["g"] = "Gitsigns prev_hunk",
}, {
	mode = "n",
	prefix = "[",
})

p.register({
	["<C-g>"] = "Toggle incline",
	["x"] = "Jaq (run the command)",
	["R"] = "Reload .vimrc",
	["N"] = "Toggle relativenumber",
	-- neogen
	["a"] = "Generate the annotations",
}, {
	mode = "n",
	prefix = "<Leader>",
})
p.register({
	["p"] = "cd $PWD",
	["s"] = "cd $SCRAPBOOK_DIR",
	r = {
		["e"] = "Replace current word",
	},
	-- telescope
	["F"] = "telescope file_all_files cwd=$SCRAPBOOK_DIR",
}, {
	mode = "n",
	prefix = ",",
})
