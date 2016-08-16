function fish_prompt
  set -q $prompt_counter; and set -gx prompt_counter 1
  set prompt_counter (expr (expr $prompt_counter + 1) \% 2)

  set -l prompt_prefix
  set -l prompt_suffix '匚＞'

  set -l normal_color     (set_color normal)
  set -l success_color    (set_color $fish_pager_color_progress ^/dev/null; or set_color cyan)
  set -l error_color      (set_color $fish_color_error ^/dev/null; or set_color red --bold)
  set -l directory_color  (set_color $fish_color_quote ^/dev/null; or set_color brown)
  set -l repository_color (set_color $fish_color_cwd ^/dev/null; or set_color green)

  set -l ahead    '↑'
  set -l behind   '↓'
  set -l diverged '⥄ '
  set -l dirty    '⨯'
  set -l none     '◦'

  if git_repo
    echo -n -s $directory_color (pwd) $normal_color ' '
    echo -n -s [ (date '+%H:%M:%S') ]
    echo -n -s ' on ' $repository_color (git_current_branch) $normal_color ' '

    if git_dirty
      echo -n $dirty
    else
      echo -n (git_ahead $ahead $behind $diverged $none)
    end
  else
    echo -n -s $directory_color (pwd) $normal_color
  end

  echo

  if test $prompt_counter -eq 1
    set prompt_prefix 'ミ'
  else
    set prompt_prefix '彡'
  end

  if test $status -eq 0
    echo -n -s $success_color $prompt_prefix : $prompt_suffix $normal_color
  else
    echo -n -s $error_color $prompt_prefix X $prompt_suffix $normal_color
  end

  echo -n ' '
end
