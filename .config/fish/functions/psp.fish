function psp
  commandline "ps -ef | peco --query '$argv'"
  commandline -f execute
end
