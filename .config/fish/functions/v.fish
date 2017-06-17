function v
  if type -qa fzf
    fzf --query "$argv" | tr '\n' ' ' | read -l files
    set -q files; or return
    commandline "vim $files"
  else
    commandline "vim $argv"
  end

  commandline -f execute
end
