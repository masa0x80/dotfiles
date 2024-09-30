vim.filetype.add({
	extension = {
		zsh = "bash",
		shell = "bash",
		age = "age",
	},
	pattern = {
		["Brewfile.*"] = "ruby",
		["zinitrc"] = "zsh",
	},
})
