dc() {
  local services=''
  if [[ "$1" == 'up' ]]; then
    services="$(yq -r '.services | keys[]' docker-compose*.yml | fzf | tr '\n' ' ')"
  fi
  eval "COMPOSE_PROJECT_NAME=$(current_dir) docker-compose $* $services"
}
