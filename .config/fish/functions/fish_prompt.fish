function fish_prompt
    set -l status_code $status
    not set -q prompt_counter && set -gx prompt_counter (math (random) % 2)
    set prompt_counter (math \($prompt_counter + 1\) \% 2)

    set -l prompt_prefix
    set -l prompt_suffix '匚＞'

    if test $prompt_counter -eq 1
        set prompt_prefix 'ミ'
    else
        set prompt_prefix '彡'
    end

    echo -n -s (__fish_git_prompt '%s ')
    if test $status_code -eq 0
        echo -n -s $prompt_prefix : $prompt_suffix
    else
        echo -n -s $prompt_prefix X $prompt_suffix
    end

    echo -n ' '
end
