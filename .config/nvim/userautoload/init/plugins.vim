let s:dein_dir = expand('~/.cache/dein')

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

call plug#begin('$HOME/.config/nvim/userautoload/plugins')

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

call dein#begin(s:dein_dir)

let s:toml_path      = '$HOME/.config/nvim/userautoload/plugins/dein.toml'
let s:lazy_toml_path = '$HOME/.config/nvim/userautoload/plugins/dein_lazy.toml'

if dein#load_cache([expand('<sfile>'), s:toml_path, s:lazy_toml_path])
  call dein#load_toml(s:toml_path,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml_path, {'lazy': 1})
  call dein#save_cache()
endif

call dein#end()

if dein#check_install()
  call dein#install()
endif
