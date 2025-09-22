return {
	{
		"is0n/jaq-nvim",
		version = "*",
		opts = {
			cmds = {
				internal = {
					lua = "luafile %",
					vim = "source %",
					javascript = "TermExec cmd='node %'",
					python = "TermExec cmd='python %'",
					rust = "TermExec cmd='rustc % && $fileBase && rm $fileBase'",
					cpp = "TermExec cmd='g++ % -o $fileBase && $fileBase'",
					go = "TermExec cmd='go run %'",
					sh = "TermExec cmd='sh %'",
					markdown = "MarkdownPreviewWrapper",
					plantuml = "PlantUMLPreview",
					mermaid = "MarkdownPreview",
				},
			},
		},
		keys = {
			{
				"<Leader>x",
				function()
					if string.find(vim.fn.expand("%"), "_spec.rb$") ~= nil then
						require("jaq-nvim").setup({
							cmds = {
								internal = {
									ruby = "TermExec cmd='rspec -f p %" .. ":" .. vim.fn.line(".") .. "'",
								},
							},
						})
					elseif
						string.find(vim.fn.expand("%"), ".+spec.tsx?$") ~= nil
						or string.find(vim.fn.expand("%"), ".+test.tsx?$") ~= nil
					then
						local test_name = vim.fn.system(
							"head -n "
								.. vim.fn.line(".")
								.. " "
								.. vim.fn.expand("%")
								.. ' | tac | rg -o "(it|test|describe)\\(.(.*).," --replace "\\$2" | head -n1 | sed -e "s/\\\'\\"\\`/./g" | tr -d "\n"'
						)
						require("jaq-nvim").setup({
							cmds = {
								internal = {
									typescript = 'TermExec cmd="npm run test % --testNamePattern=' .. test_name .. '"',
								},
							},
						})
					else
						require("jaq-nvim").setup({
							cmds = {
								internal = {
									ruby = "TermExec cmd='ruby %'",
									typescript = "TermExec cmd='npx tsx %'",
								},
							},
						})
					end
					vim.cmd("Jaq")
				end,
				desc = "QuickRun",
			},
		},
	},
}
