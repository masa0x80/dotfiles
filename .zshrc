# load common configuration
load_file $HOME/.zsh/common.zsh

# load history configuration
load_file $HOME/.zsh/history.zsh

# load completion configuration
load_file $HOME/.zsh/completion.zsh

# load plugins
load_file $HOME/.zsh/plugins.zsh

# keychain
load_file $HOME/.zsh/keychain.zsh

# カスタム設定を読み込む
for config_file ($HOME/.zsh/custom/*.zsh(N)); do
  load_file $config_file
done

# エイリアス設定の読み込み
for config_file ($HOME/.zsh/alias/*.zsh(N)); do
  load_file $config_file
done

# OSごとの設定の読み込み
for config_file ($HOME/.zsh/os/$(uname | tr '[:upper:]' '[:lower:]')/rc/*.zsh(N)); do
  load_file $config_file
done

# 環境ローカルの設定の読み込み
load_file $HOME/.private/zsh/rc

# load hook configuration
load_file $HOME/.zsh/hook.zsh

if [ ${DOTFILES:=$HOME/.dotfiles}/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

# profiling end
# if type zprof > /dev/null 2>&1; then
#   zprof | less
# fi
