target_host() {
  find nodes | grep json | fzf -1 | sed -E 's/nodes\/(.*).json/\1/'
}

vagrant_host() {
  find nodes | grep vagrant | fzf -1 | sed -E 's/nodes\/(.*).json/vagrant@\1/'
}

alias -g TH='$(target_host)'
alias -g VH='$(vagrant_host)'
alias -g kook='knife solo cook'
alias -g krepare='knife solo prepare'

knife-solo-provision-vagrant() {
  local vagrant_host="$(echo VH)"
  vagrant destroy -f && vagrant up && vagrant snapshot save init && krepare $vagrant_host && vagrant snapshot save prepared && kook $vagrant_host && vagrant snapshot save cooked
}

knife-solo-provision-target() {
  local target_host="$(echo TH)"
  krepare $target_host && kook $target_host
}
