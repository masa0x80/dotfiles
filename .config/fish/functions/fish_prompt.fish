function fish_prompt
    set -l status_code $status

    test $USER = 'root'
    and printf (set_color red)$USER(set_color normal)' '

    test $SSH_TTY
    and printf (set_color grey)$USER'@'(prompt_hostname)(set_color normal)' '

    not set -q prompt_counter && set -gx prompt_counter (math (random) % 2)
    set prompt_counter (math \($prompt_counter + 1\) \% 2)

    set -l prompt_prefix
    set -l prompt_suffix '匚＞'

    if test $prompt_counter -eq 1
        set prompt_prefix 'ミ'
    else
        set prompt_prefix '彡'
    end

    if test $status_code -eq 0
        printf '%s:%s ' $prompt_prefix $prompt_suffix
    else
        printf (set_color red)'%sX%s '(set_color normal) $prompt_prefix $prompt_suffix
    end
end
