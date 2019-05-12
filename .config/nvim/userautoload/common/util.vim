let g:vim_json_syntax_conceal = 0

" Use vim-parenmatch instead of parenmatch
let g:loaded_matchparen = 1

" Reload vimrc
noremap <Leader>R :<C-u>source $HOME/.vimrc<CR>

" Save
nnoremap <Leader>, :<C-u>set nopaste<CR>:<C-u>update<CR>

nnoremap <Leader>R :<C-u>source $HOME/.vimrc<CR>
nnoremap <silent> <Esc><Esc> :<C-u>set nopaste<CR>:<C-u>noh<CR>:<C-u>cclose<CR>
nnoremap <silent> ;; :<C-u>set nopaste<CR>:<C-u>noh<CR>:<C-u>cclose<CR>

" rubyデバッグ用
augroup RubyDebug
  autocmd!
  autocmd VimEnter,BufRead * abbreviate bb require 'pry-byebug'; binding.pry<Esc>
  autocmd VimEnter,BufRead * abbreviate bB require 'byebug'; byebug<Esc>
  autocmd VimEnter,BufRead * abbreviate Bb require 'byebug'; byebug<Esc>
  autocmd VimEnter,BufRead * abbreviate BB require 'byebug'; byebug<Esc>
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

augroup EraseTrailingSpaces
  autocmd!
  " 行末のスペース削除
  " ref: http://qiita.com/mktakuya/items/2a6cd35ca0c1b217e28c
  autocmd BufWritePre * :%s/\s\+$//ge
augroup END

augroup ExpandTab
  autocmd!
  " タブをスペースに
  autocmd BufWritePre * :retab
augroup END

augroup VsplitHelp
  autocmd!
  autocmd FileType help wincmd L
augroup END

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
