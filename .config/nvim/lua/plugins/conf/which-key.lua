-- cmp
require("which-key").register({
	["<C-l>"] = "Whole lines",
	["<C-n>"] = "Keywords in the current file",
	["<C-k>"] = "Keywords in dictionary",
	["<C-t>"] = "Keywords in thesaurus",
	["<C-i>"] = "Keywords in the current and included files",
	["<C-]>"] = "Tags",
	["<C-f>"] = "File Names",
	["<C-d>"] = "Definitions or Macros",
	["<C-v>"] = "Vim command-line",
	["<C-u>"] = "User Defined Completion",
	["<C-o>"] = "Omni Completion",
	["<C-x>"] = "Spelling Suggestions",
	["<C-c>"] = "Start Completion",
	["<C-z>"] = "Stop Completion",
}, {
	mode = "i",
	prefix = "<C-x>",
})
