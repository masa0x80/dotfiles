if globpath(&runtimepath, '') !~# 'gutentags'
  finish
endif

let g:gutentags_generate_on_write = 0
let g:gutentags_cache_dir = expand('$XDG_CACHE_HOME') .. '/gutentags'

let g:gutentags_ctags_executable = '_ctags'
let g:gutentags_ctags_executable_ruby = '_ripper-tags'
