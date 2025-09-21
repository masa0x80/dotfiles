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
		config = require("utils").load("conf/dap"),
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
		config = require("utils").load("conf/dap-vscode-js"),
	},
}
