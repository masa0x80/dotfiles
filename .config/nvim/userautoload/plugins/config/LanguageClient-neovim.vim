set hidden

let g:LanguageClient_serverCommands = {}

let g:LanguageClient_serverCommands = {
  \ 'javascript': ['~/.anyenv/envs/nodenv/shims/javascript-typescript-stdio'],
  \ 'ruby': ['~/.anyenv/envs/rbenv/shims/solargraph', 'stdio']
  \ }

augroup LanguageClient_config
  autocmd!
  autocmd User LanguageClientStarted setlocal signcolumn=yes
  autocmd User LanguageClientStopped setlocal signcolumn=auto
augroup END

let g:LanguageClient_autoStart = 1
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <Leader>lf :call LanguageClient_textDocument_formatting()<CR>
nnoremap <Leader>lh :call LanguageClient_textDocument_hover()<CR>
nnoremap <Leader>lr :call LanguageClient_textDocument_rename()<CR>
