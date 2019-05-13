function! s:bundle_open(gem_name)
  let path = system('bundle show ' . a:gem_name . ' 2>/dev/null | tail -n 1 | grep -v "not find"')
  if path == ''
    echohl Error
    echo "Could not find gem '" . a:gem_name . "'."
    echohl None
  else
    execute 'edit' path
  endif
endfunction
command! -nargs=1 Bo call s:bundle_open(<f-args>)
