require("config.plugins.colorscheme")
local set_hl = vim.api.nvim_set_hl
set_hl(0, "DapBreakpoint", { fg = Red })
set_hl(0, "DapLogPoint", { fg = Blue })
set_hl(0, "DapStopped", { fg = Green })

vim.fn.sign_define("DapBreakpoint", { text = "•", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "▷", texthl = "DapStopped" })

local keymap = vim.keymap.set
keymap("n", ",b", function()
	require("dap").toggle_breakpoint()
end, { noremap = true, desc = "DAP: Toggle Breakpoint" })
keymap("n", ",dr", function()
	require("dap").repl.open()
end, { noremap = true, desc = "DAP: Toggle REPL Open" })
keymap("n", ",dl", function()
	require("dap").run_last()
end, { noremap = true, desc = "DAP: Toggle Run Last" })

keymap("n", ",c", function()
	require("dap").continue()
end, { noremap = true, desc = "DAP: Continue" })
keymap("n", ",j", function()
	require("dap").step_over()
end, { noremap = true, desc = "DAP: Step Over" })
keymap("n", ",l", function()
	require("dap").step_into()
end, { noremap = true, desc = "DAP: Step Into" })
keymap("n", ",k", function()
	require("dap").step_out()
end, { noremap = true, desc = "DAP: Step Out" })

require("dapui").setup({
	icons = { expanded = "", collapsed = "" },
	layouts = {
		{
			elements = {
				{ id = "watches", size = 0.20 },
				{ id = "scopes", size = 0.40 },
				{ id = "stacks", size = 0.20 },
				{ id = "breakpoints", size = 0.20 },
			},
			size = 64,
			position = "right",
		},
	},
})
keymap("n", ",du", function()
	require("dapui").toggle({})
end, { noremap = true, desc = "DAP: UI Open" })

require("nvim-dap-virtual-text").setup({})

require("dap-vscode-js").setup({
	debugger_path = vim.fn.expand("$XDG_DATA_HOME/nvim/lazy/vscode-js-debug"),
	adapters = { "pwa-node" }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest Tests",
			-- trace = true, -- include debugger info
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/jest/bin/jest.js",
				-- "${fileBasename}",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
	}
end
