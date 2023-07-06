if_installed mycli abbr -S -qq --force mysql=mycli
if_installed pgcli abbr -S -qq --force psql=pgcli

if installed rg; then
  abbr -S -q g='rg --hidden'
fi

if_installed bat abbr -S -qq --force cat=bat

if installed exa; then
  alias ls='exa --group-directories-first --icons'
  abbr -S -q l='ls -a'
  abbr -S -q ll='ls -l --git'
  abbr -S -q la='ls -la --git'
  abbr -S -qq --force tree='exa -T --icons'
fi

if installed silicon; then
  abbr -S -q Si='silicon --to-clipboard --from-clipboard -l ts'
  abbr -S -q SI='silicon --to-clipboard --from-clipboard -l ts --highlight-lines "1;2-3"'
fi

# ssh {{{
if test -e "$HOME/.ssh/config"; then
  abbr -S -q ssh_config='vi ~/.ssh/config'
  abbr -S -q sconfig='vi ~/.ssh/config'
  abbr -S -q sconf='vi ~/.ssh/config'
fi
# }}}
