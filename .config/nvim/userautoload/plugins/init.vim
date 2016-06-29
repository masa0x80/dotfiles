let s:dein_sha = 'be226d268a47e79f3452a7e286d040cbca68b7bf'

let s:dein_dir       = expand('~/.cache/dein')
let s:dein_repo_dir  = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

let s:toml_path      = '$HOME/.config/nvim/userautoload/plugins/dein.toml'
let s:lazy_toml_path = '$HOME/.config/nvim/userautoload/plugins/dein_lazy.toml'

let g:dein#install_progress_type = 'title'
let g:dein#install_message_type  = 'none'
let g:dein#enable_notification   = 1

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    execute '!cd' s:dein_repo_dir '&& git checkout' s:dein_sha
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if v:version < 704 && !dein#load_state(s:dein_dir)
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

runtime! userautoload/plugins/config/*.vim
