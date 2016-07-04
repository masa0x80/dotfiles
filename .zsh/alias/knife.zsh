vagrant_host() {
  find nodes | grep vagrant | fzf -1 | sed -E 's/nodes\/(.*).json/vagrant@\1/'
}

alias -g VH='$(vagrant_host)'
alias -g kook='knife solo cook'
alias -g krepare='knife solo prepare'

knife-solo-provision-vagrant() {
  local VH="$(echo VH)"
  vagrant destroy -f && vagrant up && krepare $VH && kook $VH
}
