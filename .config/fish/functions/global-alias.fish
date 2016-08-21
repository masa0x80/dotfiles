function global-alias
  commandline -c | read -l buffer_cursor
  commandline -t | read -l alias_name
  echo "$buffer_cursor" | string replace -r "$alias_name" '' | string trim | read -l buffer_before

  switch $alias_name
  case 'GST'
    commandline "select-git-status $buffer_before"
    commandline -f execute
  case 'RET'
    commandline "set -x RAILS_ENV test; $buffer_before"
  case 'TH'
    commandline "select-target-host $buffer_before"
    commandline -f execute
  case 'VH'
    commandline "select-vagrant-host $buffer_before"
    commandline -f execute
  end
  commandline -f repaint
end
