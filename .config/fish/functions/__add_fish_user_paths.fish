function __add_fish_user_paths -a path
    contains $path $fish_user_paths || set -ga fish_user_paths $path
end
