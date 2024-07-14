-- cmp
require("which-key").add({
	mode = { "i" },
	{ "<C-x><C-]>", desc = "Tags" },
	{ "<C-x><C-c>", desc = "Start Completion" },
	{ "<C-x><C-d>", desc = "Definitions or Macros" },
	{ "<C-x><C-f>", desc = "File Names" },
	{ "<C-x><C-i>", desc = "Keywords in the current and included files" },
	{ "<C-x><C-k>", desc = "Keywords in dictionary" },
	{ "<C-x><C-l>", desc = "Whole lines" },
	{ "<C-x><C-n>", desc = "Keywords in the current file" },
	{ "<C-x><C-o>", desc = "Omni Completion" },
	{ "<C-x><C-t>", desc = "Keywords in thesaurus" },
	{ "<C-x><C-u>", desc = "User Defined Completion" },
	{ "<C-x><C-v>", desc = "Vim command-line" },
	{ "<C-x><C-x>", desc = "Spelling Suggestions" },
	{ "<C-x><C-z>", desc = "Stop Completion" },
})
