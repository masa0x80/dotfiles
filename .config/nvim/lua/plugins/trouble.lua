return {
	"folke/trouble.nvim",
	version = "*",
	cmd = { "Trouble" },
	opts = {
		modes = {
			lsp = {
				win = { position = "right" },
			},
		},
	},
	keys = {
		{ "<Leader>vv", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
		{ "<Leader>vV", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<Leader>vs", "<Cmd>Trouble symbols toggle<CR>", desc = "Symbols (Trouble)" },
		{ "<Leader>vS", "<Cmd>Trouble lsp toggle<CR>", desc = "LSP references/definitions/... (Trouble)" },
		{ "<Leader>vL", "<Cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
		{ "<Leader>vQ", "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix List (Trouble)" },
		{
			"[v",
			function()
				if require("trouble").is_open() then
					require("trouble").prev({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cprev)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Previous Trouble/Quickfix Item",
		},
		{
			"]v",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cnext)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Next Trouble/Quickfix Item",
		},
	},
}
