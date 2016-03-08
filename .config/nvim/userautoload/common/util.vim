" highlight
augroup HighlightSpaces
 autocmd!
 autocmd ColorScheme * highlight Spaces term=underline guibg=lightblue ctermbg=lightblue
 autocmd VimEnter,ColorScheme * highlight IndentGuidesEven guibg=black ctermbg=black
 autocmd VimEnter,WinEnter,BufRead * match Spaces /　\|[　 ]\+$/
augroup END

let g:vim_json_syntax_conceal = 0

" Reload vimrc
noremap <Leader>R :<C-u>source $HOME/.vimrc<CR>:noh<CR>

nnoremap <Leader>p :<C-u>set paste<CR>
nnoremap <Esc><Esc> :<C-u>set nopaste<CR>:<C-u>noh<CR>

" Save
nnoremap <Leader>, :<C-u>set nopaste<CR>:<C-u>update<CR>

" rubyデバッグ用
augroup RubyDebug
  autocmd!
  autocmd BufRead *.rb,*.spec,*.erb,*.slim abbreviate bb require 'pry-byebug'; binding.pry<Esc>
  autocmd BufRead *.rb,*.spec,*.erb,*.slim abbreviate bB require 'byebug'; byebug<Esc>
  autocmd BufRead *.rb,*.spec,*.erb,*.slim abbreviate Bb require 'byebug'; byebug<Esc>
  autocmd BufRead *.rb,*.spec,*.erb,*.slim abbreviate BB require 'byebug'; byebug<Esc>
augroup END

" ref: http://itchyny.hatenablog.com/entry/2016/02/02/210000
noremap <expr> <C-b> max([winheight(0) - 2, 1]) . "\<C-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')
noremap <expr> <C-f> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')
" noremap <expr> <C-y> (line('w0') <= 1         ? 'k' : "\<C-y>")
" noremap <expr> <C-e> (line('w$') >= line('$') ? 'j' : "\<C-e>")

augroup FileTypeGroup
  autocmd!
  " 行末のスペース削除
  " ref: http://qiita.com/mktakuya/items/2a6cd35ca0c1b217e28c
  autocmd BufWritePre * :%s/\s\+$//ge
augroup END

" ref: http://qiita.com/tekkoc/items/324d736f68b0f27680b8
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
  if 0 == a:0
    let l:arg = "."
  else
    let l:arg = a:1
  endif
  execute "%! jq " . l:arg
endfunction
