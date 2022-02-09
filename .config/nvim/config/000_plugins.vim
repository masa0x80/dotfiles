" Install vim-plug if not installed
let s:vim_plug_path = expand('$HOME/.vim/autoload/plug.vim')
if has('vim_starting') && !filereadable(s:vim_plug_path)
  silent execute '!curl -sfLo ' . s:vim_plug_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('$HOME/.local/share/nvim/plugged') " {{{ 1
Plug 'cocopon/iceberg.vim'

Plug 'lambdalisue/nerdfont.vim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/glyph-palette.vim'

Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-parenmatch'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'maximbaz/lightline-ale'
Plug 'adi/vim-indent-rainbow'
Plug 'simeji/winresizer'
Plug 'machakann/vim-sandwich'
Plug 'thinca/vim-visualstar'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tyru/columnskip.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'LeafCage/foldCC'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'DanilaMihailov/beacon.nvim'
Plug 'RRethy/vim-illuminate'

" {{{ vim-unimpaired
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
" }}} vim-unimpaired

" {{{ quickrun
Plug 'lambdalisue/vim-quickrun-neovim-job'
Plug 'thinca/vim-quickrun'
" }}} quickrun

" {{{ vim-expand-region
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'terryma/vim-expand-region'
" }}} vim-expand-region

" {{{ LSP
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'antoinemadec/coc-fzf'
" }}} LSP

" {{{ ctags
Plug 'ludovicchabant/vim-gutentags'
" }}} ctags

" {{{ neosnippet
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" }}} neosnippet

Plug 'dag/vim-fish',                 { 'for': 'fish' }
Plug 'vim-ruby/vim-ruby',            { 'for': 'ruby' }
Plug 'tpope/vim-rails',              { 'for': 'ruby' }
Plug 'mattn/vim-goimports',          { 'for': 'go' }
Plug 'slim-template/vim-slim',       { 'for': 'slim' }
Plug 'cespare/vim-toml',             { 'for': 'toml' }
Plug 'elzr/vim-json',                { 'for': 'json' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'aklt/plantuml-syntax',         { 'for': 'plantuml' }
" {{{ markdown
Plug 'godlygeek/tabular'
Plug 'mattn/vim-maketable'
Plug 'joker1007/vim-markdown-quote-syntax'
Plug 'rcmdnk/vim-markdown', { 'for': 'markdown' }
if executable('yarn')
  Plug 'iamcco/markdown-preview.nvim', {
    \  'do': 'cd app & yarn install',
    \  'for': ['markdown', 'plantuml']
    \ }
endif
" Require 'github.com/MichaelMure/mdr'
Plug 'skanehira/preview-markdown.vim'
" Run `docker run -d -p 8888:8080 plantuml/plantuml-server:jetty`, and Execute `:PreviewUML`
Plug 'skanehira/preview-uml.vim'
" }}} markdown

Plug 'tyru/vim-altercmd'
call plug#end()
" }}} 1

" Install plugins
" ref. https://github.com/junegunn/vim-plug/wiki/extra
autocmd MyAutoCmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | source $MYVIMRC
  \| endif
