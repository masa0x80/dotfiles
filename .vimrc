scriptencoding utf-8

syntax on

""" NeoBundle [start]
filetype off
filetype plugin indent off

if has('vim_starting')
  if &compatible
    set nocompatible  " Be iMproved
  endif

  " Required:
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('$HOME/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/Align'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-visualstar'
NeoBundle 'tyru/caw.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \    },
  \ }

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
""" NeoBundle [end]

" highlight
augroup HighlightSpaces
  autocmd!
  autocmd ColorScheme * highlight Spaces term=underline guibg=Gray ctermbg=Gray
  autocmd VimEnter,WinEnter * match Spaces /　\|[　 ]\+$/
augroup END

" color
set background=dark
colorscheme solarized
"let g:solarized_termcolors=256
let g:lightline = {
  \   'colorscheme': 'solarized',
  \   'mode_map': {'c': 'NORMAL'},
  \   'active': {
  \     'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
  \   },
  \   'component_function': {
  \     'modified':     'MyModified',
  \     'readonly':     'MyReadonly',
  \     'fugitive':     'MyFugitive',
  \     'filename':     'MyFilename',
  \     'fileformat':   'MyFileformat',
  \     'filetype':     'MyFiletype',
  \     'fileencoding': 'MyFileencoding',
  \     'mode':         'MyMode',
  \   },
  \ }
function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
       \  &ft == 'unite' ? unite#get_status_string() :
       \  &ft == 'vimshell' ? vimshell#get_status_string() :
       \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
let g:unite_force_overwrite_statusline = 0

set expandtab

set listchars=tab:>.
"set list

" zshっぽい補完に
set wildmode=longest,list

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

" 行番号の表示
set number
" デフォルトインデント設定
set autoindent smartindent
" タブ設定
set smarttab
set softtabstop=2 tabstop=2 shiftwidth=2
" BSの挙動
set backspace=indent,eol,start

" よしなに検索
set ignorecase smartcase
" インクメンタルサーチ
set incsearch
" 検索文字の強調表示
set hlsearch
" 検索で一番下まで行ったら上に戻る
set wrapscan

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

set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,ucs-2le,ucs-2

set hidden

set path=.\ ~/\

set viminfo+=!

set nowrap
set sidescroll=5
set listchars+=precedes:<,extends:>

" folding
set foldmethod=marker
set commentstring=%s

" mapleader
let g:mapleader=","

" Reload vimrc
noremap <Leader>R :<C-u>source $HOME/.vimrc<CR>:noh<CR>

nnoremap <Esc><Esc> :noh<CR>

" Save
nnoremap <Leader>, :<C-u>update<CR>

" Unite
nnoremap <silent> <Leader>r :<C-u>Unite file_mru<CR>
nnoremap <silent> <Leader>f :<C-u>Unite file<CR>
nnoremap <silent> <Leader>F :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> <Leader>b :<C-u>Unite buffer<CR>

augroup vimrc
  autocmd!
  autocmd FileType unite nnoremap <silent> <buffer> <ESC> :q<CR>
  autocmd FileType unite inoremap <silent> <buffer> <ESC> <ESC>:q<CR>
augroup END

autocmd Filetype json setl conceallevel=0

" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
" Set manual completion length.
let g:neocomplcache_manual_completion_start_length = 0

" QuickRun
nnoremap <silent> <Leader>x :!echo wating...<CR>:QuickRun<CR>
" 初期化
if !has("g:quickrun_config")
  let g:quickrun_config = {}
endif
" QuickRun 実行時のバッファの開き方
let g:quickrun_config._ = {
  \   'outputter' : 'buffer',
  \   'split' : 'rightbelow 10sp',
  \   '_': {
  \     'runner' : 'vimproc'
  \   },
  \ }

" NeoSnippet
"" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

"" SuperTab like snippets behavior.
imap <expr><C-j> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \ : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><C-j> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \ : "\<TAB>"

"" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" rspec
let g:quickrun_config['ruby.rspec'] = {
  \   'command': 'rspec',
  \ }
let g:quickrun_config.rspecl = {
  \   'type': 'rspec',
  \   'exec': 'bundle exec %c %s:' . line('.'),
  \ }
augroup RSpecQuickrun
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END
nnoremap <silent> <Leader>s :<C-u>QuickRun rspecl<CR>

" grep系
nnoremap <silent> <Leader>g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif

" コメントアウト
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" SEGV対策
if v:version >= 704
  set regexpengine=1
endif

" rubyデバッグ用
abbreviate bb require 'pry-byebug'; binding.pry<Esc>
abbreviate bB require 'byebug'; byebug<Esc>
abbreviate Bb require 'byebug'; byebug<Esc>
abbreviate BB require 'byebug'; byebug<Esc>
