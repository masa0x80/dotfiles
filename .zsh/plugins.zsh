source $HOME/.zplug/zplug

zplug 'plugins/git', from:oh-my-zsh
zplug 'themes/ys', from:oh-my-zsh
zplug 'mollifier/anyframe'
zplug 'b4b4r07/enhancd', of:enhancd.sh
zplug 'stedolan/jq', as:command, file:jq, from:gh-r

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load
