function __execute_wrapper
  commandline    | read -l buffer_entire
  commandline -t | read -l alias_name
  echo "$buffer_entire" | string replace -r " $alias_name" '' | string trim | read -l command

  switch $alias_name
  case 'GST'
    __select_git_status | read -l files
    commandline "$command $files"
    commandline -f execute
  case 'RET'
    commandline "env RAILS_ENV=test $command"
  case 'TH'
    __select_target_host | read -l host
    commandline "$command $host"
    commandline -f execute
  case 'VH'
    __select_vagrant_host | read -l host
    commandline "$command $host"
    commandline -f execute
  case 'GH'
    git fzf | read -l git_hash
    commandline "$command $git_hash"
    commandline -f execute
  case '*'
    commandline -f execute
  end
  commandline -f repaint
end
