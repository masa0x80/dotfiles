if [ ! -e $HOME/.zplug/zplug ]; then
  git clone https://github.com/b4b4r07/zplug $HOME/.zplug --depth=1
fi

if [ -r $HOME/.zplug/zplug ]; then
  source $HOME/.zplug/zplug

  zplug 'mafredri/zsh-async'
  zplug 'sindresorhus/pure'

  zplug 'mollifier/anyframe'
  zplug 'b4b4r07/enhancd', of:enhancd.sh

  zplug 'zsh-users/zsh-autosuggestions'
  zplug 'zsh-users/zsh-completions'

  zplug 'stedolan/jq', \
    as:command, \
    file:jq, \
    from:gh-r
  zplug 'jpmens/jo', \
    as:command, \
    do:'cd $HOME/.zplug/repos/jpmens/jo && autoreconf -i && ./configure && make check && make install'

  zplug 'junegunn/fzf-bin', \
    as:command, \
    from:gh-r, \
    file:fzf
  zplug 'junegunn/fzf', \
    as:command, \
    of:bin/fzf-tmux
  zplug 'peco/peco', \
    as:command, \
    from:gh-r

  zplug 'monochromegane/the_platinum_searcher', \
    from:gh-r, \
    do:"mkdir -p $HOME/.zplug/bin; ln -s $HOME/.zplug/{repos/**/*/pt,bin/pt}"


  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi

  zplug load
fi
