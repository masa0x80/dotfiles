local function include_plantuml_syntax(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end

	vim.api.nvim_buf_call(bufnr, function()
		-- syntax/plantuml.vim は b:current_syntax が設定済みだと何もしないので退避
		local current_syntax = vim.b[bufnr].current_syntax

		vim.cmd("syntax clear")
		vim.cmd("syntax include @markdownPlantuml syntax/plantuml.vim")
		vim.cmd(
			[[syntax region markdownPlantumlBlock keepend matchgroup=markdownPlantumlFence ]]
				.. [[start=/^\z(`\{3,}\).*\cplantuml.*$/ end=/^\z1\s*$/ contains=@markdownPlantuml]]
		)

		vim.b[bufnr].current_syntax = current_syntax
	end)
end

local function clear_raw_block_hl()
	vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", {})
end

return {
	{
		"aklt/plantuml-syntax",
		version = "*",
		-- markdown内の```plantumlブロックをVim syntaxでハイライトするため、
		-- markdown読み込み時にもsyntax/plantuml.vimがruntimepathに乗るようにする
		ft = { "plantuml", "markdown" },
		config = function()
			clear_raw_block_hl()

			local group = vim.api.nvim_create_augroup("markdownPlantumlSyntax", { clear = true })
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = group,
				callback = clear_raw_block_hl,
			})
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = "markdown",
				callback = function(args)
					vim.schedule(function()
						-- treesitterがハイライトを開始する時に`syntax`が空になり、
						-- syntax アイテムも消えるので FileType の処理後にincludeする
						include_plantuml_syntax(args.buf)
					end)
				end,
			})
		end,
	},
}
