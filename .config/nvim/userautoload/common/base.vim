set expandtab

set wildmode=list:full

" 「東アジアの文字幅」でA特性を持つものは全角幅で扱う
set ambiwidth=double

" ポップアップメニューをいい感じに
set completeopt=menu,preview,longest,menuone

" 補完候補の設定
set complete=.,w,b,u,k

" バックアップを無効に
set nobackup
set noswapfile

" 変更があったら読み込み直す
set autoread

" 行番号を表示
set nonumber

" デフォルトインデント設定
set autoindent smartindent
" タブ設定
set smarttab
set softtabstop=2 tabstop=2 shiftwidth=2
" BSの挙動
set backspace=indent,eol,start

" よしなに検索
set ignorecase smartcase
" 検索文字の強調表示
set hlsearch
set nowrapscan

" 対応する括弧の表示
set showmatch
set matchtime=1

" 入力中のコマンドを表示
set showcmd

" 行頭や行末間移動を可能に
set whichwrap=b,s,h,l,<,>,[,]

" 補完候補を表示する
set wildmenu

set splitbelow

set nrformats="hex"

set display=lastline

" ステータス表示用変数
set laststatus=2

set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,ucs-2le,ucs-2

set hidden

set path=.\ ~/\

set viminfo+=!

set nowrap
set sidescroll=5

set list
set listchars=tab:»\ ,precedes:<,extends:>

set cursorline

set synmaxcol=512

" folding
set foldmethod=marker
set commentstring=%s

" mapleader
let g:mapleader=","
