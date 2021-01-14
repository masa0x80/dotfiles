function dc
    set -l project_name (current_dir -)
    set -l services ''
    if test "$argv[1]" = 'up'
        set services (yq eval -N '.services[] | path | .[-1]' docker-compose*.yml | sort -u | fzf | tr '\n' ' ')
    end
    set -l cmd "env COMPOSE_PROJECT_NAME=$project_name docker-compose"
    test -e docker-compose.local.yml && set cmd "$cmd -f docker-compose.yml -f docker-compose.local.yml"
    commandline "$cmd $argv $services"
    commandline -f execute
end
