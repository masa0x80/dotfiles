return {
	"is0n/jaq-nvim",
	opts = {
		cmds = {
			internal = {
				lua = "luafile %",
				vim = "source %",
				javascript = "TermExec cmd='node %'",
				python = "TermExec cmd='python3 %'",
				rust = "TermExec cmd='rustc % && $fileBase && rm $fileBase'",
				cpp = "TermExec cmd='g++ % -o $fileBase && $fileBase'",
				go = "TermExec cmd='go run %'",
				sh = "TermExec cmd='sh %'",
				markdown = "MarkdownPreview",
				mermaid = "MarkdownPreview",
				plantuml = "PlantUmlPreview",
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
	dependencies = {
		{
			"akinsho/toggleterm.nvim",
			cmd = { "LG", "REV" },
			keys = {
				{ "<C-\\>" },
				{
					";F",
					"<Cmd>lua vim.cmd(vim.v.count1 .. 'ToggleTerm direction=float')<CR>",
					noremap = true,
					silent = true,
					desc = "<v:count1>ToggleTerm direction=float",
				},
				{
					";J",
					"<Cmd>lua vim.cmd(vim.v.count1 .. 'ToggleTerm direction=horizontal')<CR>",
					noremap = true,
					silent = true,
					desc = "<v:count1>ToggleTerm direction=horizontal",
				},
			},
			config = require("config.utils").load("conf/toggleterm"),
			init = require("config.utils").load("init/toggleterm"),
		},
	},
}
