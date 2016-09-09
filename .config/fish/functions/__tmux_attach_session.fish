# ref: http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc
function __tmux_attach_session
  if type -qa tmux
    if not __tmux_is_running
      if not __ssh_is_running
        if tmux has-session >/dev/null ^/dev/null
          set -q TMUX_ATTACHE_SESSION; and return
          set -g TMUX_ATTACHE_SESSION ''
          tmux list-sessions
          read -p 'echo "Tmux: attach? (y/n/num) > "' -l reply
          not set -q reply; set -g TMUX_ATTACHE_SESSION ''; and return
          switch $reply
            case Y y
              tmux attach-session
              return
            case N n ''
              return
            case '*'
              tmux attach -t "$reply"
              return
          end
        else
          tmux new -s dev
        end
      end
    end
  end
end
