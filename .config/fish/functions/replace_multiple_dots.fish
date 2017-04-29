# ref: http://qiita.com/ryotako/items/68c003afa365f84fe100
function replace_multiple_dots
  set -l token (string match '*..' -- (commandline -tc))
  if test -d "$token"
    commandline -i '/..'
  else
    commandline -i '.'
  end
end
