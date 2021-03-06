# profiling start
# zmodload zsh/zprof

# Configurations for zsh {{{

load_file() { [ -r $1 ] && . $1 }

# load useful functions
load_file $ZDOTDIR/util.zsh

# OSごとの設定の読み込み
for config_file ($ZDOTDIR/os/$UNAME_S/profile/*.zsh(N)); do
  load_file $config_file
done

# gcloud設定の読み込み
load_file /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
load_file /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

# Load local configurations (profile)
load_file $HOME/.config.local/zsh/profile

# Append $DOTFILE/bin to $PATH
# NOTE: must place after loading `$HOME/.config.local/zsh/profile`
export DOTFILE=${DOTFILE:-$HOME/.dotfiles}
export PATH=$PATH:$DOTFILE/bin

# }}}
