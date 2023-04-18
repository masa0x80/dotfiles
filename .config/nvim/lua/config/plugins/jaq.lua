require("jaq-nvim").setup({
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
			plantuml = "PlantUmlPreview",
		},
	},
})

local jaq = function()
	if string.match(vim.fn.expand("%"), "_spec.rb$") then
		require("jaq-nvim").setup({
			cmds = {
				internal = {
					-- ruby = "TermExec direction='horizontal' cmd='rspec %:" .. vim.fn.line(".") .. "'",
					ruby = "TermExec cmd='rspec -f p %" .. ":" .. vim.fn.line(".") .. "'",
				},
			},
		})
	elseif string.match(vim.fn.expand("%"), ".+spec.tsx?$") or string.match(vim.fn.expand("%"), ".+test.tsx?$") then
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
					typescript = "TermExec cmd='node %'",
				},
			},
		})
	end
	vim.cmd("Jaq")
end
vim.keymap.set("n", ",x", jaq, { noremap = true, silent = true, desc = "QuickRun" })
