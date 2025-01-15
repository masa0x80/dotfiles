# Sheldon
sheldon_cache="$XDG_CACHE_HOME/sheldon.zsh"
sheldon_toml="$HOME/.config/sheldon/plugins.toml"
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  mkdir -p $(dirname "$sheldon_cache")
  sheldon source >$sheldon_cache
fi
source "$sheldon_cache"
unset sheldon_cache sheldon_toml
