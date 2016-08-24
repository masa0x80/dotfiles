function jobs
  builtin jobs >/dev/null ^/dev/null; or return

  builtin jobs ^/dev/null| fzf | cut -f 1 | read -l num
  if test -n "$num"
    fg %$num
  end
end
