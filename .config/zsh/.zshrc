# NOTE: must place before loading `$HOME/.config.local/zsh/zshrc`
path=(
  $HOME/.bin.local(N-/)
  $HOME/.bin(N-/)
  $HOME/.local/bin(N-/)
  $path
)

setopt auto_cd
setopt auto_pushd
setopt auto_param_slash
setopt auto_menu
setopt cd_silent
setopt pushd_ignore_dups
setopt list_packed
setopt list_types
setopt auto_list
setopt magic_equal_subst
setopt brace_ccl
setopt nolistbeep
setopt extended_glob
setopt interactive_comments
setopt long_list_jobs
setopt no_bg_nice
setopt no_check_jobs
setopt no_hup

setopt correct

bindkey -e

if (( ! ${+HISTFILE} )); then
  [[ -d "$XDG_STATE_HOME/zsh" ]] || mkdir -p "$XDG_STATE_HOME/zsh"
  typeset -g HISTFILE="$XDG_STATE_HOME/zsh/history"
fi
HISTSIZE=30000
SAVEHIST=30000

setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_verify
setopt share_history

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# コマンドの出力をキャッシュし、そのパスを REPLY に入れる
#   usage: _eval_cache <name> [-d <file>]... -- <command> [args...]
# 実行ファイルの実体のパスが変わったとき（brew の Cellar のようにバージョンを含む）か、
# -d で指定したファイルがキャッシュより新しいときだけ再生成する
# NOTE: source を関数内で行うと typeset がローカル変数になるので、呼び出し側で source する
_eval_cache() {
  local name=$1 dep stamp line
  local -a deps
  shift
  while [[ $1 == -d ]]; do deps+=($2); shift 2; done
  [[ $1 == -- ]] && shift
  local bin=${commands[$1]:A}
  [[ -n $bin ]] || return 1

  REPLY=$XDG_CACHE_HOME/zsh/eval/$name.zsh
  stamp="# $bin"
  if [[ -s $REPLY ]]; then
    read -r line <$REPLY
    for dep in $deps; do [[ $dep -nt $REPLY ]] && line=; done
  fi

  if [[ $line != $stamp ]]; then
    [[ -d ${REPLY:h} ]] || mkdir -p ${REPLY:h}
    if ! { print -r -- $stamp && "$@" } >| $REPLY; then
      rm -f $REPLY $REPLY.zwc
      return 1
    fi
  fi
  # バイトコードにコンパイルしておく（source 時に zsh が新しい .zwc を自動で使う）
  [[ $REPLY.zwc -nt $REPLY ]] || zcompile $REPLY
}

_eval_cache sheldon \
  -d $XDG_CONFIG_HOME/sheldon/plugins.toml \
  -d $XDG_DATA_HOME/sheldon/plugins.lock \
  -- sheldon source && source $REPLY
_eval_cache starship -- starship init zsh && source $REPLY
# NOTE: 親プロセスから引き継いだ古い __MISE_ORIG_PATH が残っていると、
#       それ以降に追加した PATH が末尾に回されるので捨てる
unset __MISE_ORIG_PATH
# NOTE: mise activate の出力には実行時の PATH が埋め込まれるのでキャッシュしない
#       代わりにプロンプト表示後に遅延実行する（それまでは .zshenv で PATH に入れた shims を使う）
#       -2: mise の警告（untrusted な設定ファイルなど）が見えるよう stderr は捨てない
if (( ${+commands[mise]} )); then
  if (( ${+functions[zsh-defer]} )); then
    zsh-defer -2 -c 'eval "$(mise activate zsh)"'
  else
    eval "$(mise activate zsh)"
  fi
fi
_eval_cache fzf -- fzf --zsh && source $REPLY
_eval_cache direnv -- direnv hook zsh && source $REPLY
_eval_cache zabrze -- zabrze init --bind-keys && source $REPLY

autoload -Uz add-zsh-hook

zsh_dir="$ZDOTDIR/zsh.d"
for file (
  $zsh_dir/checker.zsh(N)
  $zsh_dir/aliases.zsh(N)
  $zsh_dir/complete-ssh-host.zsh(N)
  $zsh_dir/completion.zsh(N)
  $zsh_dir/dotdot.zsh(N)
  $zsh_dir/fzf.zsh(N)
  $zsh_dir/ghq.zsh(N)
  $zsh_dir/git.zsh(N)
  $zsh_dir/key-bindings.zsh(N)
  $zsh_dir/navi.zsh(N)
  $zsh_dir/prompt.zsh(N)

  # Load local configurations
  $HOME/.config.local/zsh/zshrc(N)
  $HOME/.zshrc.local(N)
) source $file
