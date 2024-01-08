local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local dap_icons = {
	DapStopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
	DapBreakpoint = " ",
	DapBreakpointCondition = " ",
	DapBreakpointRejected = { " ", "DiagnosticError" },
	DapLogPoint = ".>",
}

for name, sign in pairs(dap_icons) do
	sign = type(sign) == "table" and sign or { sign }
	vim.fn.sign_define(
		name,
		{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
	)
end
local set_hl = vim.api.nvim_set_hl
set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

for _, language in ipairs(require("config.utils").js_based_languages) do
	dap.configurations[language] = {
		-- Debug single nodejs
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file (single nodejs)",
			program = "${file}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
		},

		-- Debug nodejs server processes (make sure to add --inspect when you run the process)
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach (auto pick)",
			processId = function()
				require("dap.utils").pick_process({ filter = "node" })
			end,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach (manual pick)",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
			sourceMaps = true,
		},

		-- Debug Jest
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

		-- Debug Web applications (client side)
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch & Debug Chrome",
			url = function()
				local co = coroutine.running()
				return coroutine.create(function()
					vim.ui.input({
						prompt = "Enter URL: ",
						default = "http://localhost:3000",
					}, function(url)
						if url == nil or url == "" then
							return
						else
							coroutine.resume(co, url)
						end
					end)
				end)
			end,
			webRoot = "${workspaceFolder}",
			protocol = "inspector",
			sourceMaps = true,
			userDataDir = false,
		},

		-- Divider for the launch.json derived configs
		{
			name = "----- ↓ launch.json configs ↓ -----",
			type = "",
			request = "launch",
		},
	}
end
