return {
	{
		"neovim/nvim-lspconfig",
		version = "*",
		event = "VeryLazy",
		config = function()
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				virtual_text = {
					prefix = "",
					format = function(diagnostic)
						return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
					end,
				},
			})

			local saga = require("lspsaga")
			saga.setup({
				ui = {
					border = "rounded",
					code_action = "",
				},
				code_action = {
					keys = {
						quit = { "q", "<ESC>", "<C-c>", "<C-c><C-c>" },
					},
				},
				lightbulb = {
					virtual_text = false,
				},
				finder = {
					default = "def+ref+imp",
					keys = {
						shuttle = { "[w", "<C-l>", "<C-h>" },
						toggle_or_open = { "o", "<CR>" },
						quit = { "q", "<ESC>", "<C-c>", "<C-c><C-c>" },
						close = { "<C-c>k", "c" },
					},
				},
				preview = {
					lines_above = 9999,
					lines_below = 9999,
				},
				symbol_in_winbar = {
					enable = false,
				},
			})
			require("utils").create_autocmd({ "BufEnter" }, {
				callback = function()
					require("lspsaga").config.lightbulb.sign = vim.o.ft ~= "markdown"
				end,
			})

			local keymap = vim.keymap.set
			keymap("n", "<Leader>rn", "<Cmd>Lspsaga rename<CR>", {})
			keymap("n", "gR", "<Cmd>Lspsaga rename<CR>", {})

			keymap("n", "<Leader>ca", "<Cmd>Lspsaga code_action<CR>", {})
			keymap("n", "gC", "<Cmd>Lspsaga code_action<CR>", {})

			keymap("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", {})
			keymap("n", "<C-n>d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", {})
			keymap("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", {})
			keymap("n", "<C-p>d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", {})

			vim.lsp.enable({
				"bashls",
				"clangd",
				"cssls",
				"eslint",
				"html",
				"jdtls",
				"jsonls",
				"kotlin_language_server",
				"lua_ls",
				"nixd",
				"solargraph",
				"sourcekit",
				"tailwindcss",
				"terrarmls",
				"ts_ls",
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		version = "*",
		ft = "lua",
		opts = {},
	},
	{
		"nvimdev/lspsaga.nvim",
		version = "*",
	},
	{
		"b0o/schemastore.nvim",
		version = "*",
	},
}
