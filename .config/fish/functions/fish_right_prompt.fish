function fish_right_prompt
    printf (set_color blue)(prompt_pwd)(set_color normal)(__fish_git_prompt)' '(date +%H:%M:%S)
end
