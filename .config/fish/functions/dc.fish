function dc
    set -l project_name (current_dir)
    set -l services ''
    if test "$argv[1]" = 'up'
      yq -r '.services | keys[]' docker-compose*.yml | fzf | tr '\n' ' ' | read services
    end
    commandline "env COMPOSE_PROJECT_NAME=$project_name docker-compose $argv $services"
    commandline -f execute
end
