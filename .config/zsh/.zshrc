# プロファイル用設定
# (.zshrcの一番始めに記載すること)
if [ "$ZSHRC_PROFILE" != "" ]; then
  zmodload zsh/zprof && zprof > /dev/null
fi

# Perform cd to a directory if the typed command is invalid, but is a directory.
setopt AUTO_CD

# Make cd push the old directory to the directory stack.
setopt AUTO_PUSHD

setopt CD_SILENT

# Don't push multiple copies of the same directory to the stack.
setopt PUSHD_IGNORE_DUPS

# Don't print the directory stack after pushd or popd.
setopt PUSHD_SILENT

# Have pushd without arguments act like `pushd ${HOME}`.
setopt PUSHD_TO_HOME

# Treat `#`, `~`, and `^` as patterns for filename globbing.
setopt EXTENDED_GLOB

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Allow comments starting with `#` in the interactive shell.
setopt INTERACTIVE_COMMENTS

# Disallow `>` to overwrite existing files. Use `>|` or `>!` instead.
setopt NO_CLOBBER

# Prompt for spelling correction of commands.
setopt CORRECT

# Customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# List jobs in verbose format by default.
setopt LONG_LIST_JOBS

# Prevent background jobs being given a lower priority.
setopt NO_BG_NICE

# Prevent status report of jobs on shell exit.
setopt NO_CHECK_JOBS

# Prevent SIGHUP to jobs on shell exit.
setopt NO_HUP

# asdf
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
export NODEJS_CHECK_SIGNATURES=no
for file (
  $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh(N)
  $HOME/.asdf/plugins/java/set-java-home.zsh(N)
) source $file

# Initialize modules.
source $ZDOTDIR/zinitrc

# Prompt
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_no_bold[green]%}"
_PS1=$'
%F{blue}%~%f $(gitprompt)%f
'

_prompt() {
  counter=$(expr $(expr ${counter:-2} + 1) % 2)
  local prompt_suffix='匚＞'
  if [ $counter -eq 0 ]; then
    prompt_prefix='ミ'
  else
    prompt_prefix='彡'
  fi
  PS1="${_PS1}%(!.#.%(?,%F{magenta}${prompt_prefix}:,%F{red}${prompt_prefix}X)${prompt_suffix})%f "
}
add-zsh-hook precmd _prompt
