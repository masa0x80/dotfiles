function __execute_wrapper
  commandline | read -l buffer

  string replace -a ';' ' ;' $buffer | read buffer

  for word in (string split ' ' $buffer)
    for keyword in GST TH VH GH
      if test "$word" = "$keyword"
        switch $word
          case GST
            __select_git_status | string trim | read selected
          case TH
            __select_target_host | read selected
          case VH
            __select_vagrant_host | read selected
          case GH
            git fzf | read selected
        end
        string replace $keyword $selected $buffer | read buffer
      end
    end
  end

  for word in (string split ' ' $buffer)
    set -l keyword 'RET'
    if test "$word" = "$keyword"
      string replace $keyword '' $buffer | read buffer
      string replace 'env'    '' $buffer | read buffer
      echo "env RAILS_ENV=test $buffer" | read buffer
    end
  end

  string replace -a -r '\s+' ' ' $buffer | read buffer
  string replace -a ' ;' ';'     $buffer | read buffer

  commandline $buffer
  commandline -f execute
  commandline -f repaint
end
