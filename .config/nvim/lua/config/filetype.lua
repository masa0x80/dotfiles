vim.filetype.add({
	extension = {
		zsh = "bash",
		shell = "bash",
		age = "age",
	},
	pattern = {
		["Brewfile.*"] = "ruby",
		["zinitrc"] = "zsh",
		[".*%.md%.age"] = "markdown",
		[".*%.json%.age"] = "json",
		[".*%.csv%.age"] = "csv",
	},
})
