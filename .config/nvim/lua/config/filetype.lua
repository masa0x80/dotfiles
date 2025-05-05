vim.filetype.add({
	extension = {
		zsh = "bash",
		shell = "bash",
		age = "age",
	},
	pattern = {
		[".*/%.github/workflows/.*%.ya?ml"] = "yaml.ghaction",
		["Brewfile.*"] = "ruby",
		["zinitrc"] = "zsh",
	},
})
