# load proxy settings
test -r $HOME/.proxy && source $HOME/.proxy

# anyenv settings
export PATH=$HOME/.anyenv/bin:$PATH
if type -a anyenv > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi
