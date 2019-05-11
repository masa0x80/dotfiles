function rspec -d 'rspec wrapper'
    if command -sq rspec
        set -l cmd rspec $argv
        if command -sq spring && spring --help | grep -q rspec
            set cmd spring $cmd
        else
            set cmd command $cmd
        end
        eval $cmd
    else
        echo fish: Unknown command rspec
        return 1
    end
end
