if globpath(&runtimepath, '') !~# 'asyncomplete-buffer'
  finish
endif

let g:asyncomplete_buffer_clear_cache = 0

autocmd MyAutoCmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
  \ 'name': 'buffer',
  \ 'whitelist': ['*'],
  \ 'completor': function('asyncomplete#sources#buffer#completor'),
  \ 'priority': 20,
  \ 'config': {
  \    'max_buffer_size': 5000000,
  \  },
  \ }))
