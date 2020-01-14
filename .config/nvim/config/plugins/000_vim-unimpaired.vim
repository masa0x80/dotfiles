if globpath(&runtimepath, '') !~# 'vim-unimpaired'
  finish
endif

nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>
nnoremap [T :tabfirst<CR>
nnoremap ]T :tablast<CR>
