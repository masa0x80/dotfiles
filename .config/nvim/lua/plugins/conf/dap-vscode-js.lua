require("dap-vscode-js").setup({
	debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

	adapters = {
		"pwa-node",
		"pwa-chrome",
	},
})
