if globpath(&runtimepath, '') !~# 'gitgutter'
  finish
endif

let g:gitgutter_highlight_lines = 1

nnoremap <C-g><C-p> :GitGutterPrevHunk<CR>
nnoremap <C-g><C-n> :GitGutterNextHunk<CR>
nnoremap gh :GitGutterLineHighlightsToggle<CR>
nnoremap gp :GitGutterPreviewHunk<CR>
