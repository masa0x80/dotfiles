if globpath(&runtimepath, '') !~# 'preview-markdown'
  finish
endif

let g:preview_markdown_vertical = 1
