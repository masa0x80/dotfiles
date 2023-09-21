local color = require("config.color")
local set_hl = vim.api.nvim_set_hl
set_hl(0, "DapBreakpoint", { fg = color.RED })
set_hl(0, "DapLogPoint", { fg = color.BLUE })
set_hl(0, "DapStopped", { fg = color.GREEN })

vim.fn.sign_define("DapBreakpoint", { text = "•", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "▷", texthl = "DapStopped" })

local dap, dapui = require("dap"), require("dapui")

dapui.setup({
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.25,
				},
				{
					id = "breakpoints",
					size = 0.25,
				},
				{
					id = "stacks",
					size = 0.25,
				},
				{
					id = "watches",
					size = 0.25,
				},
			},
			position = "left",
			size = 48,
		},
		{
			elements = {
				{
					id = "repl",
					size = 1,
				},
			},
			position = "bottom",
			size = 8,
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local keymap = vim.keymap.set
keymap("n", ",B", function()
	dap.toggle_breakpoint()
end, { noremap = true, desc = "DAP: Toggle Breakpoint" })
keymap("n", ",dr", function()
	dap.repl.open()
end, { noremap = true, desc = "DAP: Toggle REPL Open" })
keymap("n", ",dl", function()
	dap.run_last()
end, { noremap = true, desc = "DAP: Toggle Run Last" })

keymap("n", ",c", function()
	dap.continue()
end, { noremap = true, desc = "DAP: Continue" })
keymap("n", ",a", function()
	dap.step_over()
end, { noremap = true, desc = "DAP: Step Over" })
keymap("n", ",s", function()
	dap.step_into()
end, { noremap = true, desc = "DAP: Step Into" })
keymap("n", ",d", function()
	dap.step_out()
end, { noremap = true, desc = "DAP: Step Out" })

keymap("n", ",du", function()
	dapui.toggle({})
end, { noremap = true, desc = "DAP: UI Open" })

require("nvim-dap-virtual-text").setup({})

require("dap-vscode-js").setup({
	debugger_path = vim.fn.expand("$XDG_DATA_HOME/nvim/lazy/vscode-js-debug"),
	adapters = { "pwa-node" },
})

for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch",
			cwd = "${workspaceFolder}",
			runtimeExecutable = "ts-node",
			args = { "${file}" },
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
			console = "integratedTerminal",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach (pick)",
			processId = function()
				require("dap.utils").pick_process({ filter = "node" })
			end,
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest Tests",
			args = {
				"node_modules/.bin/jest",
				"${fileBasename}", -- TODO: `--testNamePattern` を指定したい
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
		},
	}
end
