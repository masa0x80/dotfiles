if globpath(&runtimepath, '') !~# 'tcomment'
  finish
endif

nmap ;; :TComment<CR>
vmap ;; :TComment<CR>
