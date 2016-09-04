# ref: http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc
function __tmux_attach_session
  if type -qa tmux
    if not __tmux_is_running
      if not __ssh_is_running
        if tmux has-session >/dev/null ^/dev/null
          if test (tmux list-sessions | wc -l | string trim) -eq 1
            tmux attach-session
          else
            tmux list-sessions
          end
        else
          tmux new -s dev
        end
      end
    end
  end
end
