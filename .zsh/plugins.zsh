if [ -r $HOME/.zplug/zplug ]; then
  source $HOME/.zplug/zplug

  zplug 'mafredri/zsh-async'
  zplug 'sindresorhus/pure'
  zplug 'mollifier/anyframe'
  zplug 'b4b4r07/enhancd', of:enhancd.sh
  zplug 'zsh-users/zsh-completions'
  zplug 'zsh-users/zsh-autosuggestions'
  zplug 'jpmens/jo', \
    as:command, \
    do:'cd ~/.zplug/repos/jpmens/jo && autoreconf -i && ./configure && make check && make install'

  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi

  zplug load
fi
