return {
	"mfussenegger/nvim-dap",
	keys = {
		{
			",B",
			"<Cmd>lua require('dap').toggle_breakpoint()<CR>",
			noremap = true,
			desc = "DAP: Toggle Breakpoint",
		},
		{
			",dr",
			"<Cmd>lua require('dap').repl.open()<CR>",
			noremap = true,
			desc = "DAP: Toggle REPL Open",
		},
		{
			",dl",
			"<Cmd>lua require('dap').run_last()<CR>",
			noremap = true,
			desc = "DAP: Toggle Run Last",
		},
		{
			",c",
			"<Cmd>lua require('dap').continue()<CR>",
			noremap = true,
			desc = "DAP: Continue",
		},
		{
			",a",
			"<Cmd>lua require('dap').step_over()<CR>",
			noremap = true,
			desc = "DAP: Step Over",
		},
		{
			",s",
			"<Cmd>lua require('dap').step_into()<CR>",
			noremap = true,
			desc = "DAP: Step Into",
		},
		{
			",d",
			"<Cmd>lua require('dap').step_out()<CR>",
			noremap = true,
			desc = "DAP: Step Out",
		},

		{
			",du",
			"<Cmd>lua require('dapui').toggle()<CR>",
			noremap = true,
			desc = "DAP: UI Open",
		},
	},
	config = require("config.utils").load("conf/dap"),
	dependencies = {
		"williamboman/mason.nvim",
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
			"mxsdev/nvim-dap-vscode-js",
			dependencies = {
				{
					"microsoft/vscode-js-debug",
					-- NOTE: Fix version ref. https://github.com/mxsdev/nvim-dap-vscode-js/issues/23
					version = "v1.74.1",
					pin = true,
					build = "npm install --legacy-peer-deps && npm run compile",
				},
			},
		},
	},
}
