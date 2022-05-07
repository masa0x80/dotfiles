local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	sources = {
		formatting.stylua,
		formatting.prettier.with({
			prefer_local = "node_modules/.bin",
			disabled_filetypes = { "json" },
		}),
		diagnostics.rubocop.with({
			prefer_local = "vendor/bin",
		}),
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(clients)
							return vim.tbl_filter(function(c)
								return c.name ~= "tsserver"
							end, clients)
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
