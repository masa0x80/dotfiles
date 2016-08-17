function select-git-add
  commandline | read -l buffer
  git status --porcelain | \
        fzf --query "$buffer" | \
        awk -v git_root=:/ '{print git_root$2}' | \
        tr '\n' ' ' | \
        read -l selected_files_to_add
  if test -n "$selected_files_to_add"
    commandline "git add $selected_files_to_add"
    commandline -f execute
  end
  commandline -f repaint
end

function select-ghq-cd
  commandline | read -l buffer
  ghq list --full-path | \
        sed -e "s|$HOME/||g" | \
        fzf --query "$buffer" | \
        read -l repository_path
  if test -n "$repository_path"
    builtin cd ~/(echo $repository_path | sed -e 's/ /\\ /g')
  end
  commandline -f repaint
end

function select-history
  commandline | read -l buffer
  history | fzf --query "$buffer" | read -l command
  if test -n "$command"
    commandline $command
  end
  commandline -f repaint
end

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

## ref: http://shibayu36.hatenablog.com/entry/2014/07/26/151106
function git-recent-branches
  commandline | read -l buffer
  git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
        sed -e 's|^refs/heads/||' | \
        fzf | read -l selected_branch
  if test -n "$selected_branch"
    if test -n "$buffer"
      commandline -a $selected_branch
    else
      commandline "git checkout $selected_branch"
      commandline -f execute
    end
  end
  commandline -f repaint
end

## ref: http://shibayu36.hatenablog.com/entry/2014/07/26/151106
function git-recent-all-branches
  commandline | read -l buffer
  git for-each-ref --format='%(refname)' --sort=-committerdate | \
        sed -e 's|^refs/\(heads\|remotes\)/||' | \
        fzf | read -l selected_branch
  if test -n "$selected_branch"
    if test -n "$buffer"
      commandline -a $selected_branch
    else
      commandline "git checkout -t $selected_branch"
      commandline -f execute
    end
  end
  commandline -f repaint
end

# ref: http://motemen.hatenablog.com/entry/2015/07/mackerel-mkr-peco-zsh
function select-mkr-ip
  commandline | read -l buffer

  if test -z "$MACKEREL_APIKEY"
    builtin echo 'MACKEREL_APIKEY environment variable is not set. (Try "set MACKEREL_APIKEY=<Your apikey>")'
    commandline ''
    return 1
  end

  mkr-hosts-tsv | fzf --nth=2,3 --delimiter='\t' --query "$buffer" | read -l selected_line

  if test -n "$selected_line"
    set -l ip   (echo $selected_line | cut -f 1)
    set -l host (echo $selected_line | cut -f 2)
    commandline -a "$ip # $host"
  end
  commandline -f repaint
end
