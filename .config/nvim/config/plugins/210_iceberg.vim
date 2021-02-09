if globpath(&runtimepath, '') !~# 'iceberg\.vim'
  finish
endif

if !exists('colors_name')
  colorscheme iceberg
endif
