# load common configuration
load_file $ZDOTDIR/common.zsh

# load history configuration
load_file $ZDOTDIR/history.zsh

# load completion configuration
load_file $ZDOTDIR/completion.zsh

# load plugins
load_file $ZDOTDIR/plugins.zsh

# カスタム設定を読み込む
for config_file ($ZDOTDIR/custom/*.zsh(N)); do
  load_file $config_file
done

# OSごとの設定の読み込み
for config_file ($ZDOTDIR/os/$UNAME_S/rc/*.zsh(N)); do
  load_file $config_file
done

# load local configurations (rc)
load_file $HOME/.config.local/zsh/rc

# load hook configuration
load_file $ZDOTDIR/hook.zsh

# profiling end
# if type zprof > /dev/null 2>&1; then
#   zprof | less
# fi
