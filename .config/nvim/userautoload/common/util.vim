" Jump to head or tail
nnoremap 1 ^
nnoremap 0 $

" Emacs keybindings for insert mode
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-a> <Home>
imap <C-e> <End>
imap <C-d> <Del>

" Visual mode
vnoremap > >gv
vnoremap < <gv

" Reload vimrc
nnoremap <Leader>R :<C-u>source $HOME/.vimrc<CR>
nnoremap <silent> <Esc><Esc> :<C-u>set nopaste<CR>:<C-u>noh<CR>:<C-u>cclose<CR>
nnoremap <silent> ;; :<C-u>set nopaste<CR>:<C-u>noh<CR>:<C-u>cclose<CR>

" 行番号トグル
nnoremap <Leader>N :<C-u>setlocal relativenumber!<CR>

" 無名レジスターを保護
nnoremap x "_x

" rubyデバッグ用
augroup RubyDebug
  autocmd!
  autocmd FileType ruby abbreviate bb require 'pry'; binding.pry<Esc>
  autocmd FileType ruby abbreviate bB require 'byebug'; byebug<Esc>
  autocmd FileType ruby abbreviate Bb require 'byebug'; byebug<Esc>
  autocmd FileType ruby abbreviate BB require 'byebug'; byebug<Esc>
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
  autocmd BufRead * if &filetype != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g`\"" | endif
  autocmd FileType gitcommit call cursor(1, 128)
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

" {{{ Markdown
augroup MarkdownKeybindins
  autocmd!
  autocmd VimEnter * if &filetype == '' | execute 'set filetype=markdown' | endif
  autocmd FileType markdown inoremap <silent> <buffer> <Tab> <Esc>:<C-u>call <SID>markdown_indent('>')<CR>
  autocmd FileType markdown inoremap <silent> <buffer> <S-Tab> <Esc>:<C-u>call <SID>markdown_indent('<')<CR>
augroup END

function! s:markdown_indent(op)
  let l:col = col('.')
  call cursor(0, 1)
  if a:op == '>'
    execute(':normal ' . &shiftwidth . 'i' . ' ')
    call cursor('.', l:col + &shiftwidth)
  elseif a:op == '<'
    execute(':normal ' . &shiftwidth . 'x')
    call cursor('.', l:col - &shiftwidth)
  endif
  startinsert!
endfunction

function! s:generate_confluence_markup()
  let l:out = '/tmp/' . strftime('%FT%T') . '.confluence'
  silent execute '%y'
  execute 'edit ' . l:out
  silent execute 'put!'
  silent execute 'write'
  silent execute '0read !cat ' . l:out . ' | markdown2confluence'
  silent execute (line('.') + 1) . ',$d'
  silent execute '%y'
endfunction
command! Md2Confluence call s:generate_confluence_markup()
" }}}

augroup AutoFishIndent
  autocmd!
  autocmd BufWritePre *.fish call s:exec_fish_indent()
augroup END

function! s:exec_fish_indent()
  let l:line = line('.')
  execute '%! fish_indent'
  execute ':' . l:line
endfunction

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
