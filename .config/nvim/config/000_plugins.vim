" Install vim-plug if not installed
let s:vim_plug_path = expand('$HOME/.vim/autoload/plug.vim')
if has('vim_starting') && !filereadable(s:vim_plug_path)
  silent execute '!curl -sfLo ' . s:vim_plug_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('$HOME/.local/share/nvim/plugged') " {{{ 1
Plug 'cocopon/iceberg.vim'
Plug 'cocopon/vaffle.vim'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-parenmatch'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'maximbaz/lightline-ale'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'simeji/winresizer'
Plug 'machakann/vim-sandwich'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-visualstar'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'LeafCage/foldCC'
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" {{{ vim-expand-region
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'terryma/vim-expand-region'
" }}} vim-expand-region

" {{{ LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" }}} LSP

" {{{ asyncomplete.vim
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" }}} asyncomplete.vim

Plug 'dag/vim-fish',                 { 'for': 'fish' }
Plug 'vim-ruby/vim-ruby',            { 'for': 'ruby' }
Plug 'tpope/vim-rails',              { 'for': 'ruby' }
Plug 'slim-template/vim-slim',       { 'for': 'slim' }
Plug 'cespare/vim-toml',             { 'for': 'toml' }
Plug 'elzr/vim-json',                { 'for': 'json' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
" {{{ markdown
Plug 'godlygeek/tabular'
Plug 'joker1007/vim-markdown-quote-syntax'
Plug 'rcmdnk/vim-markdown', { 'for': 'markdown' }
" }}} markdown
call plug#end()
" }}} 1

" Install plugins
" ref. https://github.com/junegunn/vim-plug/wiki/extra
autocmd MyAutoCmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | source $MYVIMRC
  \| endif
