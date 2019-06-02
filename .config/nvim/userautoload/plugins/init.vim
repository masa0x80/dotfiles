let s:dein_sha = '03ad2dcea1b747ac9862deec620903438a938296'

let s:dein_dir      = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    call execute('!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir)
    call execute('!cd ' . s:dein_repo_dir)
    call execute('!git checkout ' . s:dein_sha)
  endif
  call execute('set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p'))
endif

let g:dein#install_progress_type = 'title'
let g:dein#install_message_type  = 'none'
let g:dein#enable_notification   = 1

if !dein#load_state(s:dein_dir)
  finish
endif

let s:dein_toml = '$HOME/.config/nvim/userautoload/plugins/dein.toml'
let s:lazy_toml = '$HOME/.config/nvim/userautoload/plugins/dein_lazy.toml'

call dein#begin(s:dein_dir, [expand('<sfile>'), s:dein_toml, s:lazy_toml])
call dein#load_toml(s:dein_toml, {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy' : 1})

call dein#end()
call dein#save_state()

if dein#check_install()
  call dein#install()
endif
