call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
call denite#custom#source('file_rec', 'matcher', ['matcher_fuzzy', 'matcher_cpsm'])
call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
call denite#custom#option('default', 'prompt', '>')
if executable('pt')
  call denite#custom#var('grep', 'command', ['pt', '--nogroup', '--nocolor', '--smart-case', '--hidden'])
  call denite#custom#var('grep', 'default_opts', [])
  call denite#custom#var('grep', 'recursive_opts', [])
endif

call denite#custom#map('insert', "\<C-n>", 'move_to_next_line')
call denite#custom#map('insert', "\<C-p>", 'move_to_prev_line')
call denite#custom#map('insert', "\<C-f>", 'scroll_page_forwards')
call denite#custom#map('insert', "\<C-u>", 'scroll_window_upwards')
call denite#custom#map('insert', "\<C-b>", 'scroll_page_backwards')
call denite#custom#map('insert', "\<C-d>", 'scroll_window_downwards')

function! s:git_root()
  let git_root_path = system('git rev-parse --show-toplevel')
  if v:shell_error == 128
    let root_path = getcwd()
  else
    let root_path = substitute(git_root_path, "\n", '', 'g')
  end
  return root_path
endfunction

nnoremap <silent> <Leader>b :<C-u>Denite -mode=normal buffer<CR>
nnoremap <silent> <Leader>E :<C-u>Denite -mode=normal file_mru<CR>
nnoremap <silent> <Leader>j :<C-u>Denite line<CR>
nnoremap <silent> <Leader>r :<C-u>Denite -resume<CR>

" grep
nnoremap <silent> <Leader>g :<C-u>Denite grep:.<CR>
nnoremap <silent> <leader>G :<C-u>Denite -mode=normal grep:. -input=<C-r><C-w><CR><CR>

" Rails
nnoremap <silent> <Leader>C :<C-u>Denite -path=`<SID>git_root()`/app/controllers        file_rec/git<CR>
nnoremap <silent> <Leader>D :<C-u>Denite -path=`<SID>git_root()`/db                     file_rec/git<CR>
nnoremap <silent> <Leader>H :<C-u>Denite -path=`<SID>git_root()`/app/helpers            file_rec/git<CR>
nnoremap <silent> <Leader>I :<C-u>Denite -path=`<SID>git_root()`/config/initializers    file_rec/git<CR>
nnoremap <silent> <Leader>J :<C-u>Denite -path=`<SID>git_root()`/app/assets/javascripts file_rec/git<CR>
nnoremap <silent> <Leader>M :<C-u>Denite -path=`<SID>git_root()`/app/models             file_rec/git<CR>
nnoremap <silent> <Leader>S :<C-u>Denite -path=`<SID>git_root()`/app/assets/stylesheets file_rec/git<CR>
nnoremap <silent> <Leader>T :<C-u>Denite -path=`<SID>git_root()`/spec                   file_rec/git<CR>
nnoremap <silent> <Leader>V :<C-u>Denite -path=`<SID>git_root()`/app/views              file_rec/git<CR>
