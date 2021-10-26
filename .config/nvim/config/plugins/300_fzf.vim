if globpath(&runtimepath, '') !~# 'fzf'
  finish
endif

autocmd MyAutoCmd FileType fzf
  \  set laststatus=0 noshowmode noruler
  \| autocmd MyAutoCmd BufLeave <buffer> set laststatus=2 showmode ruler

nnoremap <silent> <Leader>f :<C-u>Files<CR>
nnoremap <silent> <Leader><Leader> :<C-u>Buffers<CR>

if executable('rg')
  nnoremap <silent> <Leader>g :<C-u>RG<CR>
  nnoremap <silent> <Leader>G :<C-u>RG <C-r>=expand('<cword>')<CR><CR>
  nnoremap <silent> ,g :<C-u>GG<CR>
  nnoremap <silent> ,G :<C-u>GG <C-r>=expand('<cword>')<CR><CR>
endif

nnoremap <silent> <Leader>t :<C-u>Tags<CR>
nnoremap <silent> <Leader>T :<C-u>Tags <C-r>=expand('<cword>')<CR><CR>

function! RipgrepFzf(query, fullscreen)
  let command_fmt_smart  = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let command_fmt_ignore = 'rg --column --line-number --no-heading --color=always --ignore-case -- %s || true'
  let command_fmt_hidden = 'rg --column --line-number --no-heading --color=always --smart-case --hidden -- %s || true'
  let initial_command = printf(command_fmt_ignore, shellescape(a:query))
  let reload_command_smart  = printf(command_fmt_smart, '{q}')
  let reload_command_ignore = printf(command_fmt_ignore, '{q}')
  let reload_command_hidden = printf(command_fmt_hidden, '{q}')
  let spec = {'options': ['--phony', '--query', a:query,
      \ '--bind', 'change:reload:'.reload_command_ignore,
      \ '--bind', 'ctrl-g:toggle-all',
      \ '--bind', 'ctrl-/:deselect-all',
      \ '--bind', 'alt-l:reload:'.reload_command_ignore,
      \ '--bind', 'alt-s:reload:'.reload_command_smart,
      \ '--bind', 'alt-h:reload:'.reload_command_hidden]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

function! GemGrep(query, fullscreen)
  let command_fmt_smart  = 'rg --column --line-number --no-heading --color=always --smart-case -- %s vendor/bundle/ || true'
  let command_fmt_ignore = 'rg --column --line-number --no-heading --color=always --ignore-case -- %s vendor/bundle/ || true'
  let command_fmt_hidden = 'rg --column --line-number --no-heading --color=always --smart-case --hidden -- %s vendor/bundle || true'
  let initial_command = printf(command_fmt_ignore, shellescape(a:query))
  let reload_command_smart  = printf(command_fmt_smart, '{q}')
  let reload_command_ignore = printf(command_fmt_ignore, '{q}')
  let reload_command_hidden = printf(command_fmt_hidden, '{q}')
  let spec = {'options': ['--phony', '--query', a:query,
      \ '--bind', 'change:reload:'.reload_command_ignore,
      \ '--bind', 'ctrl-g:toggle-all',
      \ '--bind', 'ctrl-/:deselect-all',
      \ '--bind', 'alt-l:reload:'.reload_command_ignore,
      \ '--bind', 'alt-s:reload:'.reload_command_smart,
      \ '--bind', 'alt-h:reload:'.reload_command_hidden]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang GG call GemGrep(<q-args>, <bang>0)

command! -nargs=0 GHQ call fzf#run({
  \ 'source': 'ghq list --full-path',
  \ 'sink': 'cd'
  \ })
