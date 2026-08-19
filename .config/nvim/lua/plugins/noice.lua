return {
	{
		"folke/noice.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				routes = {
					{
						filter = {
							event = "notify",
							find = "No information available",
						},
						opts = { skip = true },
					},
				},
				messages = {
					view = "mini",
					view_error = "mini",
					view_warn = "mini",
					view_search = false,
				},
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_makdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
					},
				},
			})

			vim.keymap.set("n", "<Leader>m", "<Cmd>NoiceAll<CR>", { desc = "Show All Messages" })
		end,
		dependencies = {
			"rcarriga/nvim-notify",
			version = "*",
			keys = {
				{
					"<leader>un",
					function()
						require("notify").dismiss({ silent = true, pending = true })
					end,
					desc = "Dismiss all Notifications",
				},
			},
			opts = {
				timeout = 10000,
			},
		},
	},
}
