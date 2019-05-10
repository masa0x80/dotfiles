function dc
    set -l project_name (current_dir)
    commandline "env COMPOSE_PROJECT_NAME=$project_name docker-compose $argv"
    commandline -f execute
end
