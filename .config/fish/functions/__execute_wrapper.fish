function __execute_wrapper
  commandline | read -l buffer

  string replace -a -r '(;|\|)' ' $1' $buffer | read buffer

  for word in (string split ' ' $buffer)
    for keyword in F G H L N N1 N2 P T GST TH VH GH
      if string match -q $keyword -- $word
        switch $word
          case F
            set replacement '| fzf'
          case G
            set replacement '| egrep --color=auto'
          case H
            set replacement '| head'
          case L
            set replacement '| less'
          case N
            set replacement ' >/dev/null ^/dev/null'
          case N1
            set replacement ' >/dev/null'
          case N2
            set replacement ' ^/dev/null'
          case P
            set replacement '| peco'
          case T
            set replacement '| tail'
          case GST
            __select_git_status | string trim | read replacement
          case TH
            __select_target_host | read replacement
          case VH
            __select_vagrant_host | read replacement
          case GH
            git fzf | read replacement
        end
        string replace $keyword $replacement $buffer | read buffer
      end
    end
  end

  for word in (string split ' ' $buffer)
    set -l keyword 'RET'
    if string match -q $keyword -- $word
      string replace $keyword '' $buffer | read buffer
      string replace 'env'    '' $buffer | read buffer
      echo "env RAILS_ENV=test $buffer" | read buffer
    end
  end

  string replace -a -r '\s+' ' ' $buffer | read buffer
  string replace -a ' ;' ';' $buffer | read buffer

  commandline $buffer
  commandline -f execute
  commandline -f repaint
end
