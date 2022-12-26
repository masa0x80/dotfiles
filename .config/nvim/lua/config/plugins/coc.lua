vim.g.coc_node_args = { "--max-old-space-size=4096" }
vim.g.coc_global_extensions = {
	"coc-lists",
	"coc-snippets",
	"coc-solargraph",
	"coc-go",
	"coc-java",
	"coc-tsserver",
	"coc-eslint",
	"coc-prettier",
	"coc-sumneko-lua",
	"coc-stylua",
	"coc-markdownlint",
	"coc-html",
	"coc-css",
	"coc-json",
	"coc-yaml",
	"coc-toml",
	"coc-tailwindcss",
	"coc-swagger",
	"coc-sh",
	"coc-fish",
	"coc-markmap",
	"coc-vimlsp",
}

local keyset = vim.keymap.set
function _G.check_back_space()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset(
	"i",
	"<TAB>",
	'coc#pum#visible() ? coc#_select_confirm() : coc#expandableOrJumpable() ? \'<C-r>=coc#rpc#request("doKeymap", ["snippets-expand-jump", ""])<CR>\' :  v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
	opts
)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

keyset("i", "<C-e>", [[coc#pum#visible() ? coc#pum#cancel() : "\<Esc>A"]], opts)
keyset("i", "<C-j>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-j>"]], opts)

keyset("n", "[d", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]d", "<Plug>(coc-diagnostic-next)", { silent = true })

function _G.show_docs()
	local cw = vim.fn.expand("<cword>")
	if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
		vim.api.nvim_command("h " .. cw)
	elseif vim.api.nvim_eval("coc#rpc#ready()") then
		vim.fn.CocActionAsync("doHover")
	else
		vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
	end
end
keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

vim.api.nvim_create_autocmd("CursorHold", {
	group = "_",
	command = "silent call CocActionAsync('highlight')",
	desc = "Highlight symbol under cursor on CursorHold",
})

keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

keyset("n", "<leader>ca", "<Plug>(coc-codeaction)", { silent = true })
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", { silent = true })

opts = { silent = true, nowait = true }
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

vim.api.nvim_create_user_command("Markmap", "CocCommand mapkmap.create -w", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd({ "VimEnter", "ColorScheme" }, {
	group = "_",
	pattern = "*",
	command = "highlight CocMenuSel gui=underline guibg=#282c34",
})

autocmd({ "FileType" }, {
	group = "_",
	pattern = "*",
	-- Setup formatexpr
	command = "setlocal formatexpr=CocAction('formatSelected')",
})

-- For go
autocmd({ "BufWritePre" }, {
	pattern = "*.go",
	command = "CocCommand editor.action.organizeImport",
})
