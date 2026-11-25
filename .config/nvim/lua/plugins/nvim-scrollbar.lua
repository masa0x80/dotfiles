return {
	{
		"petertriho/nvim-scrollbar",
		version = "*",
		event = { "BufNewFile", "BufRead" },
		config = function()
			require("hlslens").setup({
				nearest_only = true,
				virt_priority = 64,
			})

			local map = vim.keymap.set
			map("n", "*", function()
				require("lasterisk").search()
				require("hlslens").start()
			end)

			map({ "n", "x" }, "g*", function()
				require("lasterisk").search({ is_whole = false, silent = true })
				require("hlslens").start()
			end)

			require("scrollbar").setup({
				marks = {
					Search = {
						highlight = "Orange",
					},
				},
				exclude = {
					filetypes = {
						"",
						"cmp_docs",
						"cmp_menu",
						"noice",
						"prompt",
					},
				},
				providers = {
					search = true,
				},
				scrollbar = {
					hide_if_all_visible = true,
				},
			})
		end,
	},
	{
		"rapan931/lasterisk.nvim",
		version = "*",
	},
	{
		"kevinhwang91/nvim-hlslens",
		-- version = "*",
	},
}
