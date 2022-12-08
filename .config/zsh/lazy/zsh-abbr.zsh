bindkey '^J' abbr-expand-and-accept

if_installed open abbr -S -q o=open

if_installed mycli abbr -S -q mysql=mycli
if_installed pgcli abbr -S -q psql=pgcli

if installed rg; then
  abbr -S -q g='rg --hidden'
fi

if_installed bat abbr -S -qq --force cat=bat
if_installed dog abbr -S -qq --force dig=dog
if_installed sd abbr -S -qq --force sed=sd
if_installed fd abbr -S -qq --force find=fd

if installed exa; then
  alias ls='exa --group-directories-first --icons'
  abbr -S -q l='ls -a'
  abbr -S -q ll='ls -l --git'
  abbr -S -q la='ls -la --git'
  abbr -S -q tree='exa -T --icons'
fi

if installed silicon; then
  abbr -S -q Si='silicon --to-clipboard --from-clipboard -l ts'
  abbr -S -q SI='silicon --to-clipboard --from-clipboard -l ts --highlight-lines "1;2-3"'
fi

# ssh {{{
if test -e "$HOME/.ssh/config"; then
  abbr -S -q ssh_config='eval $EDITOR ~/.ssh/config'
  abbr -S -q sconfig='eval $EDITOR ~/.ssh/config'
  abbr -S -q sconf='eval $EDITOR ~/.ssh/config'
fi
# }}}
