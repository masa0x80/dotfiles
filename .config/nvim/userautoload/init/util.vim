" highlight
augroup HighlightSpaces
  autocmd!
  autocmd ColorScheme * highlight Spaces term=underline guibg=lightblue ctermbg=lightblue
  autocmd VimEnter,ColorScheme * highlight IndentGuidesEven guibg=black ctermbg=black
  autocmd VimEnter,WinEnter,BufRead * match Spaces /　\|[　 ]\+$/
augroup END

autocmd Filetype json setl conceallevel=0

" Reload vimrc
noremap <Leader>R :<C-u>source $HOME/.vimrc<CR>:noh<CR>

nnoremap <Leader>P :<C-u>set paste<CR>o
nnoremap <Esc><Esc> :<C-u>set nopaste<CR>:<C-u>noh<CR>

" Save
nnoremap <Leader>, :<C-u>set nopaste<CR>:<C-u>update<CR>

" rubyデバッグ用
augroup RubyDebug
  autocmd!
  autocmd Filetype ruby,spec abbreviate bb require 'pry-byebug'; binding.pry<Esc>
  autocmd Filetype ruby,spec abbreviate bB require 'byebug'; byebug<Esc>
  autocmd Filetype ruby,spec abbreviate Bb require 'byebug'; byebug<Esc>
  autocmd Filetype ruby,spec abbreviate BB require 'byebug'; byebug<Esc>
augroup END
