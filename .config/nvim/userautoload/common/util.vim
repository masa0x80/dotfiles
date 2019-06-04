let g:vim_json_syntax_conceal = 0

" Use vim-parenmatch instead of parenmatch
let g:loaded_matchparen = 1

" Save
nnoremap <Leader>, :<C-u>set nopaste<CR>:<C-u>update<CR>

" Reload vimrc
nnoremap <Leader>R :<C-u>source $HOME/.vimrc<CR>
nnoremap <silent> <Esc><Esc> :<C-u>set nopaste<CR>:<C-u>noh<CR>:<C-u>cclose<CR>
nnoremap <silent> ;; :<C-u>set nopaste<CR>:<C-u>noh<CR>:<C-u>cclose<CR>

" 行番号トグル
nnoremap <Leader>N :<C-u>setlocal relativenumber!<CR>

" 無名レジスターを保護
nnoremap x "_x
nnoremap dd "_dd
nnoremap D "_D

" rubyデバッグ用
augroup RubyDebug
  autocmd!
  autocmd FileType ruby abbreviate bb binding.pry<Esc>
  autocmd FileType ruby abbreviate bB byebug<Esc>
  autocmd FileType ruby abbreviate Bb byebug<Esc>
  autocmd FileType ruby abbreviate BB byebug<Esc>
augroup END

augroup SSHConfig
  autocmd!
  autocmd BufEnter $HOME/.ssh/conf.d/* set filetype=sshconfig
augroup END

augroup FileTypes
  autocmd!
  autocmd BufEnter,BufRead,BufNewFile *.yml,*.yml.tmpl set filetype=yaml
  autocmd BufEnter,BufRead,BufNewFile .envrc,.envrc.tmpl set filetype=sh
augroup END

" ref: http://itchyny.hatenablog.com/entry/2016/02/02/210000
noremap <expr> <C-b> max([winheight(0) - 2, 1]) . "\<C-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')
noremap <expr> <C-f> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')
" noremap <expr> <C-y> (line('w0') <= 1         ? 'k' : "\<C-y>")
" noremap <expr> <C-e> (line('w$') >= line('$') ? 'j' : "\<C-e>")

" Save cursor position
augroup KeepLastPosition
  autocmd!
  autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g`\"" | endif
augroup END

" ref: https://vim-jp.org/vim-users-jp/2010/07/19/Hack-162.html
if has('persistent_undo')
  set undodir=./.vimundo,~/.vimundo
  set undofile
endif

augroup HighlightSpaces
  autocmd!
  autocmd ColorScheme * match Visual /　\|[　 ]\+$/
augroup END

augroup VsplitHelp
  autocmd!
  autocmd FileType help wincmd L
augroup END

augroup AutoFishIndent
  autocmd!
  autocmd BufWritePre fish call s:exec_fish_indent()
augroup END

function! s:exec_fish_indent()
  let l:line = line('.')
  execute '%! fish_indent'
  execute ':' . l:line
endfunction

function! s:generate_confluence_markup()
  let l:in = expand('%:p')
  let l:out = expand('%:p:r') . '.confluence'
  execute ':e confluence'
  execute '0r!markdown2confluence ' . l:in
endfunction
command! Md2Confluence call s:generate_confluence_markup()

" ref: http://qiita.com/tekkoc/items/324d736f68b0f27680b8
function! s:Jq(...)
  if 0 == a:0
    let l:arg = "."
  else
    let l:arg = a:1
  endif
  execute "%! jq " . l:arg
endfunction
command! -nargs=? Jq call s:Jq(<f-args>)
