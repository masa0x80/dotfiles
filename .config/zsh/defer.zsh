r() {
  local repo=$(ghq list -p | sed -n "s|$HOME/\(.*\)|\1|p" | fzf +m --query="$@" --preview 'bat --color=always ~/{}/README.md')

  if test -n "$repo"; then
    cd "$HOME/$repo"
  fi
}


#
# Hooks
#

check-envrc-exist() {
  if [ -f $(pwd)/.envrc ]; then
    if [ ! $(grep -q '\[env\]' mise.toml >/dev/null 2>&1) ]; then
      echo -e '\n\033[7;36m[WARN] .envrc is found.\033[0;39m'
    fi
  fi
}
add-zsh-hook precmd check-envrc-exist

check-local-git-config() {
  if [ ! -f $HOME/.config.local/git/config ]; then
    echo -e '\n\033[7;36m[WARN] Local git config file is not found. Create ~/.config.local/git/config file.\033[0;39m'
  fi
}
add-zsh-hook precmd check-local-git-config

_prompt() {
  counter=$(expr $(expr ${counter:-1} + 1) % 2)
  local prompt_suffix='匚＞'
  if [ $counter -eq 0 ]; then
    prompt_prefix='ミ'
  else
    prompt_prefix='彡'
  fi
  PURE_PROMPT_SYMBOL="%(!.#.%(?,%F{magenta}${prompt_prefix}:,%F{red}${prompt_prefix}X)${prompt_suffix})%f"
}
add-zsh-hook precmd _prompt


#
# Key bindings
#

# ref: http://qiita.com/d6rkaiz/items/46e9c61c412c89e84c38
complete-ssh-host() {
  local host="$(command grep -E -i '^Host\s+.+' $HOME/.ssh/config $(find $HOME/.ssh/conf.d -type f 2>/dev/null) | command grep -E -v '[*?]' | awk '{print $2}' | sort | fzf)"

  if [ ! -z "$host" ]; then
    LBUFFER+="$host"
  fi
  zle reset-prompt
}
zle -N complete-ssh-host
bindkey '^gs' complete-ssh-host

function dotdot() {
  local dots=$LBUFFER[-3,-1]
  if [[ $dots =~ "^[ //\"']?\.\.$" ]]; then
    LBUFFER=$LBUFFER[1,-3]'../.'
  fi
  zle self-insert
}
zle -N dotdot
bindkey "." dotdot

git-add() {
  IFS=$'\n'
  for f in $(git -c color.status=always status -s | fzf -m --query="$@" \
    --preview 'F=$(echo {2..} | sed "s|\"\(.*\)\"|\1|");
      [[ {1} = "??" ]] && bat --color=always "$F" || \
      [[ {} =~ "^D. " ]] && git diff --color=always --cached -- "$F" || \
      [[ {} =~ "^[MA]. " ]] && git diff --color=always --staged -- "$F" || \
      git diff --color=always -- "$F"' | cut -c4-); do
    if [ "$BUFFER" = "" ]; then
      BUFFER="git add"
    fi
    BUFFER+=" ./$f"
    zle end-of-line
    zle accept-line
  done
}
zle -N git-add
bindkey "^g^a" git-add


git-switch-local-branch() {
  local branch=$(git branch --color=always --format='%(refname:short)' --sort=-committerdate -l | fzf +m +s --preview 'git log --color=always --graph {1} --format="%C(auto)%h%d %s %C(blue)%cr %C(green)%cN"')
  if test -n "$branch"; then
    if test "$BUFFER" = ''; then
      BUFFER="git switch $branch"
      zle end-of-line
      zle accept-line
    else
      BUFFER="${LBUFFER}${branch}${RBUFFER}"
      CURSOR+=${#branch}
      zle redisplay
    fi
  fi
}
zle -N git-switch-local-branch
bindkey "^g^b" git-switch-local-branch

git-switch-remote-branch() {
  git fetch
  local branch=$(git branch --color=always --format='%(refname:short)' --sort=-committerdate -r | grep -Ev '^origin$' | fzf +m +s --query="$BUFFER" --preview 'git log --color=always --graph {1} --format="%C(auto)%h%d %s %C(blue)%cr %C(green)%cN"' | sed -e 's|origin/||')
  if test -n "$branch"; then
    git branch --format='%(refname:short)' --sort=-committerdate -l | grep -E -q "^${branch}$"
    if [ "$?" = 1 ]; then
      BUFFER="git switch -t origin/$branch"
    else
      BUFFER="git switch $branch"
    fi
    zle end-of-line
    zle accept-line
  fi
}
zle -N git-switch-remote-branch
bindkey "^g^g^b" git-switch-remote-branch


__call_navi() {
  navi --path .cheats.d/:"$(navi info cheats-path)" --fzf-overrides --no-exact --print --query="$@"
}
navi-widget() {
  local result="$(__call_navi "$BUFFER" | perl -pe 'chomp if eof')"
  BUFFER="$result"
  zle end-of-line
  zle redisplay
}
zle -N navi-widget
bindkey "^g^i" navi-widget


autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
# include words that is at least two characters long
zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'
bindkey "^]" insert-last-word

# Shift-Tabで補完候補を逆順で選択する
bindkey '^[[Z' reverse-menu-complete
# Ctrl-oで補完候補を逆順で選択する
bindkey '^O' reverse-menu-complete

bindkey '^G^U' undo
bindkey '^G^R' redo

bindkey '^G^H' backward-word
bindkey '^G^L' forward-word

# reegnz/jq-zsh-plugin
bindkey '^G^J' jq-complete

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# zabrze (brewで入れる想定)
eval "$(zabrze init --bind-keys)"

# ref. [最近のzshrcとその解説](https://mollifier.hatenablog.com/entry/20090502/p1)
# quote previous word in single or double quote
autoload -U modify-current-argument
_quote-previous-word-in-single() {
  modify-current-argument '${(qq)${(Q)ARG}}'
  zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-single
bindkey '^[s' _quote-previous-word-in-single

_quote-previous-word-in-double() {
  modify-current-argument '${(qqq)${(Q)ARG}}'
  zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-double
bindkey '^[d' _quote-previous-word-in-double


#
# fzf
#

if (( ${+commands[fzf]} )); then
  export FZF_DEFAULT_OPTS='--ansi --reverse --extended --multi --cycle --bind=ctrl-u:page-up,ctrl-d:page-down,ctrl-j:preview-down,ctrl-k:preview-up,ctrl-g:toggle-all,ctrl-/:deselect-all,ctrl-q:deselect-all'
  FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#d0d0d0,bg:#333333,hl:#5f87af --color=fg+:#d0d0d0,bg+:#262626,hl+:#61afef --color=info:#afaf87,prompt:#e06c75,pointer:#e5c07b --color=marker:#98c379,spinner:#aab2bf,header:#87afaf'

  if (( ${+commands[fd]} )); then
    export FZF_DEFAULT_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -tf'
    export FZF_ALT_C_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -td'
    FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
  fi

  if (( ${+commands[bat]} )); then
    export FZF_CTRL_T_OPTS="--preview 'command bat --color=always --line-range :500 {}'"
  fi

  if [ -n "$TMUX" ]; then
    export FZF_TMUX_OPTS="-p 80% --border none"
    alias fzf="fzf-tmux ${FZF_TMUX_OPTS-}"
  fi

  if (( ${+commands[fd]} && ${+commands[bat]} )); then
    # CTRL-T - Paste the selected file path(s) into the command line
    __fsel() {
      local cmd="${FZF_CTRL_T_COMMAND}"
      setopt localoptions pipefail no_aliases 2> /dev/null
      local item
      eval "$cmd" | FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS-} ${FZF_CTRL_T_OPTS-}" fzf -m | while read item; do
        echo -n "${(q)item} "
      done
      local ret=$?
      echo
      return $ret
    }

    fzf-file-widget() {
      LBUFFER="${LBUFFER}$(__fsel)"
      local ret=$?
      zle reset-prompt
      return $ret
    }

    # ALT-C - cd into the selected directory
    fzf-cd-widget() {
      local cmd="${FZF_ALT_C_COMMAND}"
      setopt localoptions pipefail no_aliases 2> /dev/null
      local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS-} ${FZF_ALT_C_OPTS-}" fzf +m)"
      if [[ "$dir" = '' ]]; then
        zle reset-prompt
        return 0
      fi
      LBUFFER="${LBUFFER}${(q)dir}"
      local ret=$?
      zle reset-prompt
      return $ret
    }

    fzf-t-widget() {
      if test "$LBUFFER" = "cd "; then
        fzf-cd-widget
      else
        fzf-file-widget
      fi
    }
    zle -N fzf-t-widget
    bindkey '^T' fzf-t-widget
  fi
fi


#
# complition
#

# Move cursor to end of word if a full completion is inserted.
setopt always_to_end

setopt no_case_glob

# Don't beep on ambiguous completions.
setopt no_list_beep

zstyle ':completion::complete:*' use-cache on

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion::complete:*' use-cache on

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list '' 'r:|?=**'

# Ignore useless commands and functions
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'
# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order 'indexes' 'parameters'

# Directories
if (( ${+LS_COLORS} )); then
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
else
  # Use same LS_COLORS definition from utility module, in case it was not set
  zstyle ':completion:*:default' list-colors ${(s.:.):-di=1;34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43}
fi
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*' squeeze-slashes true

# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Populate hostname completion.
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts{,2} 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts 2>/dev/null; ypcat hosts 2>/dev/null)"}%%(\#)*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config{,.d/*(N)} 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns \
  '_*' adm amanda apache avahi beaglidx bin cacti canna clamav daemon dbus \
  distcache dovecot fax ftp games gdm gkrellmd gopher hacluster haldaemon \
  halt hsqldb ident junkbust ldap lp mail mailman mailnull mldonkey mysql \
  nagios named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
  operator pcap postfix postgres privoxy pulse pvm quagga radvd rpc rpcuser \
  rpm shutdown squid sshd sync uucp vcsa xfs

# ... unless we really want to.
zstyle '*' single-ignored show

# Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true


# Load gcloud
if test -d $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/; then
  source $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
  source $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi


# misc
cache_file="$ZDOTDIR/cache/mise.zsh"
test -r "$cache_file" || mise activate zsh > $cache_file
cache_file="$ZDOTDIR/cache/fzf.zsh"
test -r "$cache_file" || fzf --zsh > $cache_file
cache_file="$ZDOTDIR/cache/direnv.zsh"
test -r "$cache_file" || direnv hook zsh > $cache_file
for file (
  $ZDOTDIR/cache/mise.zsh(N)
  $ZDOTDIR/cache/fzf.zsh(N)
  $ZDOTDIR/cache/direnv.zsh(N)
) zsh-defer source $file

# delete expired cache files
zsh-defer find $ZDOTDIR/cache -type f -mtime +7 | xargs -I{} rm {}

export AGE_IDENTITY="$HOME/.config/age/key.txt"
export AGE_RECIPIENT=$(grep -oP '(?<=# public key: ).+(?=)' $AGE_IDENTITY)
export PASSAGE_IDENTITIES_FILE="$HOME/.ssh/key"
export PASSAGE_RECIPIENTS_FILE="$HOME/.ssh/key.pub"
export PASSAGE_AGE="$HOMEBREW_PREFIX/bin/rage"


# XXX
compdef _zbnc_zsh_better_npm_completion npm

# NOTE: must place before loading `$HOME/.config.local/zsh/zshrc
export GHQ_ROOT="$HOME/.ghq"
if installed ghq; then
  if [[ ! -d "$GHQ_ROOT/github.com/masa0x80/dotfiles" ]]; then
    export DOTFILE="$GHQ_ROOT/github.com/masa0x80/dotfiles"
  else
    export DOTFILE="${DOTFILE:-$HOME/.dotfiles}"
  fi
fi

zsh-defer source $HOME/.bin/_set_browser

for file (
  # Load local configurations
  $HOME/.config.local/zsh/zshrc(N)
  $HOME/.zshrc.local(N)
) zsh-defer source $file

# NOTE: must place before loading `$HOME/.config.local/zsh/zshrc`
path=(
  $HOME/.bin.local(N-/)
  $HOME/.bin(N-/)
  $path
)


# NOTE: Create zsh compiled files
() {
  local src
  for src in $@; do
    [ ! -f ${src}.zwc -o $src -nt ${src}.zwc ] && zsh-defer zcompile $src
  done
} $HOME/.zshenv(N) $ZDOTDIR/.zshrc(N) $ZDOTDIR/*.zsh(N) $ZDOTDIR/defer.zsh(N) $ZDOTDIR/cache/*.zsh(N) $HOME/.config.local/zsh/zshenv(N) $HOME/.config.local/zsh/zshrc(N) $HOME/.zshenv.local(N) $HOME/.zshrc.local(N)
