let s:dein_sha = '4c3cec4eebf0e02cb8a04dc6ea3e8356ddb383ef'

let s:dein_dir       = expand('~/.cache/dein')
let s:dein_repo_dir  = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

let s:toml_path      = '$HOME/.config/nvim/userautoload/plugins/dein.toml'
let s:lazy_toml_path = '$HOME/.config/nvim/userautoload/plugins/dein_lazy.toml'

let g:dein#install_progress_type = 'title'
let g:dein#install_message_type  = 'none'
let g:dein#enable_notification   = 1

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    call execute('!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir)
    call execute('!cd ' . s:dein_repo_dir)
    call execute('!git checkout ' . s:dein_sha)
  endif
  call execute('set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p'))
endif

if !dein#load_state(s:dein_dir)
  finish
endif

call dein#begin(s:dein_dir, [expand('<sfile>'), s:toml_path, s:lazy_toml_path])
call dein#load_toml(s:toml_path,      {'lazy': 0})
call dein#load_toml(s:lazy_toml_path, {'lazy': 1})

call dein#end()
call dein#save_state()

if dein#check_install()
  call dein#install()
endif
