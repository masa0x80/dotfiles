if globpath(&runtimepath, '') !~# 'asyncomplete-buffer'
  finish
endif

autocmd MyAutoCmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
  \ 'name': 'buffer',
  \ 'allowlist': ['*'],
  \ 'completor': function('asyncomplete#sources#buffer#completor'),
  \ 'config': {
  \    'max_buffer_size': 5000000,
  \  },
  \ }))
