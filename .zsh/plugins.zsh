if [ ! -e $ZPLUG_HOME ]; then
  ZPLUG_REVISION='d8199dd4b910f00c325a050134dcf93a072f158b'
  git clone https://github.com/zplug/zplug.git $ZPLUG_HOME
  cd $ZPLUG_HOME && git checkout $ZPLUG_REVISION
  source $ZPLUG_HOME/init.zsh
fi

if [ -r $HOME/.zplug/zplug ]; then
  source $HOME/.zplug/zplug

  zplug 'mafredri/zsh-async'
  zplug 'sindresorhus/pure'

  zplug 'mollifier/anyframe'
  zplug 'b4b4r07/enhancd', use:enhancd.sh

  zplug 'zsh-users/zsh-autosuggestions'
  zplug 'zsh-users/zsh-completions'

  zplug 'stedolan/jq', \
    as:command, \
    from:gh-r, \
    rename-to:jq
  zplug 'b4b4r07/emoji-cli', \
    on:'stedolan/jq'

  if [[ $OSTYPE != darwin* ]]; then
    zplug 'jpmens/jo', \
      as:command, \
      hook-build:'cd $HOME/.zplug/repos/jpmens/jo && autoreconf -i && ./configure --prefix=$HOME/.zplug && make check && make install'

    zplug 'junegunn/fzf-bin', \
      as:command, \
      from:gh-r, \
      rename-to:fzf, \
      use:"*linux*amd64*", \
      on:junegunn/fzf
    zplug 'junegunn/fzf', \
      as:command, \
      use:bin/fzf-tmux
  fi

  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi

  zplug load
fi
