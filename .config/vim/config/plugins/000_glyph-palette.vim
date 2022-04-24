if globpath(&runtimepath, '') !~# 'glyph-palette'
  finish
endif

autocmd MyAutoCmd FileType fern call glyph_palette#apply()
