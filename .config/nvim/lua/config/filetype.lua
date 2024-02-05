vim.filetype.add({
	extension = {
		zsh = "bash",
		shell = "bash",
	},
	pattern = {
		["Brewfile.*"] = "ruby",
		["zinitrc"] = "zsh",
	},
})
