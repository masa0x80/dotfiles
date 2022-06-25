local status_ok, p = pcall(require, "null-ls")
if not status_ok then
	return
end

local formatting = p.builtins.formatting
local diagnostics = p.builtins.diagnostics

p.setup({
	sources = {
		formatting.stylua,
		formatting.prettier.with({
			prefer_local = "node_modules/.bin",
			disabled_filetypes = { "json" },
		}),
		diagnostics.eslint.with({
			prefer_local = "node_modules/.bin",
			filetypes = { "graphql" },
		}),
		diagnostics.rubocop.with({
			prefer_local = "vendor/bin",
		}),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_create_augroup("LspFormat" .. bufnr, {})
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				group = "LspFormat" .. bufnr,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(clients)
							return vim.tbl_filter(function(c)
								return c.name ~= "tsserver"
							end, clients)
						end,
						async = false,
						timeout_ms = 10000,
					})
				end,
			})
		end
	end,
})
