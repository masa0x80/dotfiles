if globpath(&runtimepath, '') !~# 'coc\.nvim'
  finish
endif

let g:coc_global_extensions = [
  \ 'coc-solargraph',
  \ 'coc-go',
  \ 'coc-tsserver',
  \ 'coc-markdownlint',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-toml',
  \ 'coc-css',
  \ 'coc-tailwindcss',
  \ 'coc-swagger',
  \ 'coc-neosnippet',
  \ 'coc-fzf-preview',
  \ 'coc-sh',
  \ 'coc-fish']

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-n>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')



" coc-fzf-preview
" `--resume` is very important
nnoremap <Leader>g :<C-u>CocCommand fzf-preview.ProjectGrep . --add-fzf-arg=--bind=ctrl-u:deselect-all,ctrl-g:toggle-all --resume<CR>
nnoremap <Leader>G :<C-u>CocCommand fzf-preview.ProjectGrep . --add-fzf-arg=--bind=ctrl-u:deselect-all,ctrl-g:toggle-all --add-fzf-arg=--query="<C-r>=expand('<cword>')<CR>"<CR>
