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
					require("lspsaga").config.lightbulb.sign = vim.bo.filetype ~= "markdown"
				end,
			})

			local keymap = vim.keymap.set
			for _, lhs in ipairs({ "<Leader>rn", "gR" }) do
				keymap("n", lhs, "<Cmd>Lspsaga rename<CR>")
			end
			for _, lhs in ipairs({ "<Leader>ca", "gC" }) do
				keymap("n", lhs, "<Cmd>Lspsaga code_action<CR>")
			end
			for _, lhs in ipairs({ "]d", "<C-n>d" }) do
				keymap("n", lhs, "<Cmd>Lspsaga diagnostic_jump_next<CR>")
			end
			for _, lhs in ipairs({ "[d", "<C-p>d" }) do
				keymap("n", lhs, "<Cmd>Lspsaga diagnostic_jump_prev<CR>")
			end

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
				"terraformls",
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
