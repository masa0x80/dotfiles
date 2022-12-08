# プロファイル用設定
#
# (.zshrcの一番始めに記載すること)
#
if [ "$ZSHRC_PROFILE" != "" ]; then
  zmodload zsh/zprof && zprof > /dev/null
fi

# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
setopt CORRECT

# Customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# --------------------
# Module configuration
# --------------------

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
# typeset -A ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# Initialize modules.
source ${ZDOTDIR}/.zinitrc

# Load bash function `complete` by running the following autoload
autoload -Uz +X bashcompinit && bashcompinit

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down
bindkey "^G^P" history-search-backward
bindkey "^G^N" history-search-forward

# }}} End configuration added by Zim install

#
# Custom Configurations
#

# Load hooks configurations
for config_file ($ZDOTDIR/hooks/*.zsh(N)) source $config_file

# Load files under conf.d
for config_file ($ZDOTDIR/conf.d/*.zsh(N)) source $config_file

# Append $DOTFILE/bin to $PATH
path=($DOTFILE/bin(N-/) $path)

# Load local configurations
load_file $HOME/.config.local/zsh/zshrc

# Load local config
load_file $HOME/.zshrc.local
