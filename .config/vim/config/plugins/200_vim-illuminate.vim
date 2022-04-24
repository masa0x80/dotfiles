if globpath(&runtimepath, '') !~# 'vim-illuminate'
  finish
endif

autocmd MyAutoCmd VimEnter * hi illuminatedWord cterm=underline gui=underline
