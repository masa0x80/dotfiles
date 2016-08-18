function select-ssh
  ruby -e "File.read('$HOME/.ssh/config').scan(/Host ([^*?\s]+)\n(?:  .*\n)*  # HostName: ([^\n]+)\n/).each do |info|
    puts '%s # %s' % [info[0].ljust(30, ' '), info[1]]
  end" | sort | fzf | read -l selected_line

  set -l host (echo $selected_line | cut -d ' ' -f 1)
  set -l note (echo $selected_line | cut -d '#' -f 2)

  if test -n "$selected_line"
    commandline -a "$host # $note"
  end
  commandline -f repaint
end
