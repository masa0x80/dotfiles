dc() {
  local services=''
  if [[ "$1" == 'up' ]]; then
    services="$(yq -r '.services | keys[]' docker-compose*.yml | sort -u | fzf | tr '\n' ' ')"
  fi
  local f_option=''
  if [ -e docker-compose.local.yml ]; then
    f_option='-f docker-compose.yml -f docker-compose.local.yml'
  fi
  eval "COMPOSE_PROJECT_NAME=$(current_dir -) docker-compose $f_option $* $services"
}
