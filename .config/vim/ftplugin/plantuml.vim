if globpath(&runtimepath, '') !~# 'markdown-preview.nvim'
  finish
endif

command! -buffer MarkdownPreview call mkdp#util#open_preview_page()
