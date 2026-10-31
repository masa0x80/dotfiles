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
						local meta = {}
						for _, v in ipairs({ "source", "code" }) do
							if diagnostic[v] ~= nil and diagnostic[v] ~= "" then
								table.insert(meta, tostring(diagnostic[v]))
							end
						end
						if #meta == 0 then
							return diagnostic.message
						end
						return string.format("%s (%s)", diagnostic.message, table.concat(meta, ": "))
					end,
				},
			})

			local keymap = vim.keymap.set
			for _, lhs in ipairs({ "<Leader>rn", "gR" }) do
				keymap("n", lhs, vim.lsp.buf.rename, { desc = "LSP: rename" })
			end
			for _, lhs in ipairs({ "<Leader>ca", "gC" }) do
				keymap("n", lhs, vim.lsp.buf.code_action, { desc = "LSP: code action" })
			end
			for _, lhs in ipairs({ "]d", "<C-n>d" }) do
				keymap("n", lhs, function()
					vim.diagnostic.jump({ count = vim.v.count1, float = true })
				end, { desc = "Diagnostic: next" })
			end
			for _, lhs in ipairs({ "[d", "<C-p>d" }) do
				keymap("n", lhs, function()
					vim.diagnostic.jump({ count = -vim.v.count1, float = true })
				end, { desc = "Diagnostic: prev" })
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
		"b0o/schemastore.nvim",
		version = "*",
	},
}
