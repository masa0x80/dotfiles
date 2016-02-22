if [ -r $HOME/.zplug/zplug ]; then
  source $HOME/.zplug/zplug

  zplug 'mafredri/zsh-async'
  zplug 'sindresorhus/pure'
  zplug 'mollifier/anyframe'
  zplug 'b4b4r07/enhancd', of:enhancd.sh
  zplug 'zsh-users/zsh-completions'

  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi

  zplug load
fi
