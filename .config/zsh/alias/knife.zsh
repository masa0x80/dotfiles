target_host() {
  find nodes | grep json | fzf -1 | sed -E 's/nodes\/(.*).json/\1/'
}

vagrant_host() {
  find nodes | grep vagrant | fzf -1 | sed -E 's/nodes\/(.*).json/vagrant@\1/'
}

alias -g TH='$(target_host)'
alias -g VH='$(vagrant_host)'

ksv() {
  local vagrant_host="$(echo VH)"
  vagrant destroy -f && vagrant up && vagrant snapshot save init && knife solo prepare $vagrant_host && vagrant snapshot save prepared && knife solo cook $vagrant_host && vagrant snapshot save cooked
}

kst() {
  local target_host="$(echo TH)"
  knife solo prepare $target_host && knife solo cook $target_host
}

kzv() {
  local vagrant_host="$(echo VH)"
  vagrant destroy -f && vagrant up && vagrant snapshot save init && knife zero bootstrap $vagrant_host --node-name $vagrant_host --no-converge && vagrant snapshot save prepared && knife zero converge nmae:$vagrant_host && vagrant snapshot save cooked
}

kzt() {
  local target_host="$(echo TH)"
  knife zero bootstrap $target_host --node-name $target_host --no-converge && knife zero converge name:$target_host
}
