return {
	{
		"is0n/jaq-nvim",
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
				",x",
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
									typescript = "TermExec cmd='ts-node %'",
								},
							},
						})
					end
					vim.cmd("Jaq")
				end,
				noremap = true,
				silent = true,
				desc = "QuickRun",
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "LG", "REV" },
		keys = {
			{ "<C-\\>" },
			{
				"<Leader>tf",
				"<Cmd>TermFloat<CR>",
				noremap = true,
				silent = true,
				desc = "<v:count1>ToggleTerm direction=float",
			},
			{
				"<Leader>tb",
				"<Cmd>TermBottom<CR>",
				noremap = true,
				silent = true,
				desc = "<v:count1>ToggleTerm direction=horizontal",
			},
		},
		init = require("config.utils").load("init/toggleterm"),
		config = require("config.utils").load("conf/toggleterm"),
	},
}
