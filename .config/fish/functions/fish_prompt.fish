function fish_prompt
  set -l status_code $status
  set -q $prompt_counter; and set -gx prompt_counter 1
  set prompt_counter (math \($prompt_counter + 1\) \% 2)

  set -l prompt_prefix
  set -l prompt_suffix '匚＞'

  set -l color_time       $color_white
  set -l color_directory  $color_blue

  echo -n -s $color_directory (prompt_pwd) $color_normal ' '
  echo -n -s $color_time (date '+%H:%M:%S') $color_normal
  echo -n -s (__fish_git_prompt)
  echo ' '

  if test $prompt_counter -eq 1
    set prompt_prefix 'ミ'
  else
    set prompt_prefix '彡'
  end

  if test $status_code -eq 0
    echo -n -s $color_success $prompt_prefix : $prompt_suffix $color_normal
  else
    echo -n -s $color_error $prompt_prefix X $prompt_suffix $color_normal
  end

  echo -n ' '
end
