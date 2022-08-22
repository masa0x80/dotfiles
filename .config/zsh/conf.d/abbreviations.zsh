if_installed open abbr -S -q o=open

if_installed mycli abbr -S -q mysql=mycli
if_installed pgcli abbr -S -q psql=pgcli

if installed rg; then
  abbr -S -q g='rg --hidden'
fi

if_installed bat abbr -S -qq --force cat=bat

# ssh {{{
if test -e "$HOME/.ssh/config"; then
  abbr -S -q ssh_config='eval $EDITOR ~/.ssh/config'
  abbr -S -q sconfig='eval $EDITOR ~/.ssh/config'
  abbr -S -q sconf='eval $EDITOR ~/.ssh/config'
fi
# }}}
