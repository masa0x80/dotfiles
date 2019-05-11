function rails -d 'rails wrapper'
    if command -sq rails
        set -l cmd rails $argv
        if command -sq spring
            set cmd spring $cmd
        else
            set cmd command $cmd
        end
        eval $cmd
    else
        echo fish: Unknown command rails
        return 1
    end
end
