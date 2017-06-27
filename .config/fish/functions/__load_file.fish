function __load_file
    test -r $argv
    and source $argv
end
