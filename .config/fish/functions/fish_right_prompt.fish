function fish_right_prompt
    echo -n (set_color blue)(prompt_pwd)(set_color normal)
    echo -n (__fish_git_prompt)
    echo -n ' '(date +%H:%M:%S)
end
