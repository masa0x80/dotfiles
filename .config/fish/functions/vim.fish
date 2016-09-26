function vim
  if type -qa nvim
    nvim $argv
  else
    vim $argv
  end
end
