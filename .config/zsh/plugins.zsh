if [ ! -e $ZPLUG_HOME ]; then
  ZPLUG_REVISION='305b88c02b255bcf9c817749b0e3ca1e7f981dee'
  git clone https://github.com/zplug/zplug.git $ZPLUG_HOME
  cd $ZPLUG_HOME && git checkout $ZPLUG_REVISION
  source $ZPLUG_HOME/init.zsh
fi

if [ -r $HOME/.zplug/zplug ]; then
  source $HOME/.zplug/zplug

  zplug 'mafredri/zsh-async'
  zplug 'sindresorhus/pure'

  zplug 'mollifier/anyframe'

  zplug 'zsh-users/zsh-autosuggestions'
  zplug 'zsh-users/zsh-completions'

  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi

  zplug load
fi
