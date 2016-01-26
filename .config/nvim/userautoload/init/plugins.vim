call plug#begin('$HOME/.config/nvim/plugged')

if has('lua')
  Plug 'Shougo/neocomplete.vim'
elseif has('nvim')
  Plug 'Shougo/deoplete.nvim'
else
  Plug 'Shougo/neocomplcache.vim'
endif
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/Align'
Plug 'junegunn/vim-easy-align'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-visualstar'
Plug 'tomtom/tcomment_vim'
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

call plug#end()

" plugin installation check
let s:plug = {
      \ "plugs": get(g:, 'plugs', {})
      \ }

function! s:plug.check_installation()
  if empty(self.plugs)
    return
  endif

  let list = []
  for [name, spec] in items(self.plugs)
    if !isdirectory(spec.dir)
      call add(list, spec.uri)
    endif
  endfor

  if len(list) > 0
    let unplugged = map(list, 'substitute(v:val, "^.*github\.com/\\(.*/.*\\)\.git$", "\\1", "g")')

    " Ask whether installing plugs like NeoBundle
    echomsg 'Not installed plugs: ' . string(unplugged)
    if confirm('Install plugs now?', "yes\nNo", 2) == 1
      PlugInstall
      " Close window for vim-plug
      silent! close
      " Restart vim
      silent! !vim
      quit!
    endif

  endif
endfunction

augroup check-plug
  autocmd!
  autocmd VimEnter * if !argc() | call s:plug.check_installation() | endif
augroup END
