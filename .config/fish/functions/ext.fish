function ext
    argparse -x 'a,d' 'a/add' 'e/ext=' 'd/del' -- $argv || return

    if set -q _flag_del
        # Delete ext
        set -l name $argv[1]
        set -l new_name (string replace -r '\.([^.]*)$' '' $name)

        if test -f $new_name
            echo Error: $new_name exists.
        else
            commandline "mv $name $new_name"
        end
    else
        # Add ext
        set -l ext 'bk'
        if set -q _flag_ext
            set ext $_flag_ext
        end

        set -l name $argv[1]
        set -l new_name $name.$ext

        if test -f $new_name
            echo Error: $new_name exists.
        else
            commandline "mv $name{,.$ext}"
        end
    end
    commandline -f execute
end
