function __execute_wrapper
    commandline | read -l buffer

    string replace -a -r '(;|\|)' ' $1' $buffer | read buffer

    for word in (string split ' ' $buffer)
        set -l keyword 'RET'
        if string match -q $keyword -- $word
            string replace $keyword '' $buffer | read buffer
            string replace 'env' '' $buffer | read buffer
            echo "env RAILS_ENV=test $buffer" | read buffer
        end
    end

    string replace -a -r '\s+' ' ' $buffer | read buffer
    string replace -a ' ;' ';' $buffer | read buffer

    commandline $buffer
    commandline -f execute
end
