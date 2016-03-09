# load common configuration
CONFIG_FILE="$HOME/.zsh/common.zsh" && test -r $CONFIG_FILE && source $CONFIG_FILE

# load history configuration
CONFIG_FILE="$HOME/.zsh/history.zsh" && test -r $CONFIG_FILE && source $CONFIG_FILE

# load completion configuration
CONFIG_FILE="$HOME/.zsh/completion.zsh" && test -r $CONFIG_FILE && source $CONFIG_FILE

# load hook configuration
CONFIG_FILE="$HOME/.zsh/hook.zsh" && test -r $CONFIG_FILE && source $CONFIG_FILE

# load plugins
CONFIG_FILE="$HOME/.zsh/plugins.zsh" && test -r $CONFIG_FILE && source $CONFIG_FILE

# カスタム設定を読み込む
for CONFIG_FILE ($HOME/.zsh/custom/*.zsh(N)); do
  source $CONFIG_FILE
done

# エイリアス設定の読み込み
for CONFIG_FILE ($HOME/.zsh/alias/*.zsh(N)); do
  source $CONFIG_FILE
done

# OSごとの設定の読み込み
for CONFIG_FILE ($HOME/.zsh/os/$(uname | tr A-Z a-z)/zshrc.zsh(N)); do
  source $CONFIG_FILE
done

CONFIG_FILE="$HOME/.zshrc.local" && test -r $CONFIG_FILE && source $CONFIG_FILE # 環境ローカルの設定の読み込み
unset CONFIG_FILE

# profiling end
# if type zprof > /dev/null 2>&1; then
#   zprof | less
# fi
