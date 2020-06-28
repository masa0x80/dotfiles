function __load_file
    set -l file_path $argv
    test -r $file_path && source $file_path
end
