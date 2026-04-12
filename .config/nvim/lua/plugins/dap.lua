return {
	{
		"mfussenegger/nvim-dap",
		version = "*",
		keys = {
			{
				"<C-,>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				noremap = true,
				desc = "DAP: Toggle Breakpoint",
			},
			{
				"<C-,>c",
				function()
					require("dap").continue()
				end,
				noremap = true,
				desc = "DAP: Continue",
			},
			{
				"<C-,>s",
				function()
					require("dap").step_into()
				end,
				noremap = true,
				desc = "DAP: Step Into",
			},
			{
				"<C-,>n",
				function()
					require("dap").step_over()
				end,
				noremap = true,
				desc = "DAP: Step Over",
			},
			{
				"<C-,>f",
				function()
					require("dap").step_out()
				end,
				noremap = true,
				desc = "DAP: Step Out",
			},

			{
				"<C-,>du",
				function()
					require("dapui").toggle()
				end,
				noremap = true,
				desc = "DAP: UI Open",
			},
		},
		config = function()
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

			vim.fn.sign_define(
				"DapStopped",
				{ text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }
			)
			vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = " ", texthl = "DiagnosticError", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "", linehl = "", numhl = "" })
			local set_hl = vim.api.nvim_set_hl
			set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

			for _, language in ipairs(require("utils").js_based_languages) do
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
		end,
	},
	{
		"nvim-neotest/nvim-nio",
	},
	{
		"rcarriga/nvim-dap-ui",
		opts = {
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
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {},
	},
	{
		"microsoft/vscode-js-debug",
		build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && mv dist out",
		commit = "bc551bf4f87a6ef9330b28514bf7447cbbdb2a9e",
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

				adapters = {
					"pwa-node",
					"pwa-chrome",
				},
			})
		end,
	},
}
