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

vim.cmd([[
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"
inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"

inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>A"

inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#confirm() : "\<C-j>"

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>"


" Use `[d` and `]d` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ca  <Plug>(coc-codeaction)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" coc-markmap
" Create markmap from the whole file
command! Markmap CocCommand markmap.create -w
]])

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
