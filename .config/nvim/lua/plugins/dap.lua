return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				",b",
				function()
					require("dap").toggle_breakpoint()
				end,
				noremap = true,
				desc = "DAP: Toggle Breakpoint",
			},
			{
				",c",
				function()
					if vim.fn.filereadable(".vscode/launch.json") then
						local dap_vscode = require("dap.ext.vscode")
						dap_vscode.load_launchjs(nil, {
							["pwa-node"] = require("config.utils").js_based_languages,
							["chrome"] = require("config.utils").js_based_languages,
							["pwa-chrome"] = require("config.utils").js_based_languages,
						})
					end
					require("dap").continue()
				end,
				noremap = true,
				desc = "DAP: Continue",
			},
			{
				",s",
				function()
					require("dap").step_into()
				end,
				noremap = true,
				desc = "DAP: Step Into",
			},
			{
				",n",
				function()
					require("dap").step_over()
				end,
				noremap = true,
				desc = "DAP: Step Over",
			},
			{
				",f",
				function()
					require("dap").step_out()
				end,
				noremap = true,
				desc = "DAP: Step Out",
			},

			{
				",du",
				function()
					require("dapui").toggle()
				end,
				noremap = true,
				desc = "DAP: UI Open",
			},
		},
		config = require("config.utils").load("conf/dap"),
		dependencies = {
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
			},
			{
				"mxsdev/nvim-dap-vscode-js",
				config = require("config.utils").load("conf/dap-vscode-js"),
			},
			{
				"Joakker/lua-json5",
				build = "./install.sh",
			},
		},
	},
}
