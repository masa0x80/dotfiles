set autoread
set nobackup
set noswapfile
set nowrap
set linebreak
set hidden
set splitbelow
set cursorline
set number
set relativenumber

set expandtab
set autoindent smartindent
set smarttab
set softtabstop=2 tabstop=2 shiftwidth=2

set wildmode=list:full
set completeopt=menu,preview,longest,menuone
set complete=.,w,b,u,k

set list
set listchars=tab:»\ ,precedes:<,extends:>
set wildmenu

set fileencodings=utf-8
set ambiwidth=double

set laststatus=2
set display=lastline

set ignorecase smartcase
set hlsearch
set nowrapscan

set noshowmode

set showmatch
set matchtime=1

set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]

set path=.\ ~/\
set viminfo+=!
set sidescroll=5
set synmaxcol=512

set foldcolumn=0
set foldlevel=2
set foldmethod=marker
set commentstring=%s

" ref. https://vim-jp.org/vim-users-jp/2010/07/19/Hack-162.html
if has('persistent_undo')
  set undodir=./.vimundo,~/.vimundo
  set undofile
endif
