return {
	on_attach = function(client, bufnr)
		require("utils").create_autocmd({ "BufWritePre" }, {
			buffer = bufnr,
			callback = function()
				if vim.g.formatter_enabled then
					client:request_sync("workspace/executeCommand", {
						command = "eslint.applyAllFixes",
						arguments = {
							{
								uri = vim.uri_from_bufnr(bufnr),
								version = vim.lsp.util.buf_versions[bufnr],
							},
						},
					}, nil, bufnr)
				end
			end,
		})
	end,
}
