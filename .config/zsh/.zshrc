# プロファイル用設定
# (.zshrcの一番始めに記載すること)
if [ "$ZSHRC_PROFILE" != "" ]; then
  zmodload zsh/zprof && zprof > /dev/null
fi

#
# Changing directories
#

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

#
# Expansion and globbing
#

# Treat `#`, `~`, and `^` as patterns for filename globbing.
setopt EXTENDED_GLOB


#
# History
#

# The file to save the history in.
if (( ! ${+HISTFILE} )) typeset -g HISTFILE=${ZDOTDIR:-${HOME}}/.zhistory

# The maximum number of events stored internally and saved in the history file.
# The former is greater than the latter in case user wants HIST_EXPIRE_DUPS_FIRST.
HISTSIZE=20000
SAVEHIST=10000

# Don't display duplicates when searching the history.
setopt HIST_FIND_NO_DUPS

# Don't enter immediate duplicates into the history.
setopt HIST_IGNORE_DUPS

# Remove commands from the history that begin with a space.
setopt HIST_IGNORE_SPACE

# Don't execute the command directly upon history expansion.
setopt HIST_VERIFY

# Cause all terminals to share the same history 'session'.
setopt SHARE_HISTORY

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

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

#
# Job control
#

# List jobs in verbose format by default.
setopt LONG_LIST_JOBS

# Prevent background jobs being given a lower priority.
setopt NO_BG_NICE

# Prevent status report of jobs on shell exit.
setopt NO_CHECK_JOBS

# Prevent SIGHUP to jobs on shell exit.
setopt NO_HUP

#
# Completion enhancements
#

[[ ${TERM} != dumb ]] && () {
  # Autoload functions
  fpath=($ZDOTDIR/functions(N-/) $fpath)
  for config_file ($ZDOTDIR/functions/*(N)) autoload $(basename "$config_file")

  # Load and initialize the completion system
  local zdumpfile glob_case_sensitivity completion_case_sensitivity
  glob_case_sensitivity=insensitive
  zstyle -s ':zim:completion' dumpfile 'zdumpfile' || zdumpfile=${ZDOTDIR:-${HOME}}/.zcompdump
  completion_case_sensitivity=insensitive
  autoload -Uz compinit && compinit -C -d ${zdumpfile}
  autoload -Uz +X bashcompinit && bashcompinit

  # Compile the completion dumpfile; significant speedup
  if [[ ! ${zdumpfile}.zwc -nt ${zdumpfile} ]] zcompile ${zdumpfile}

  #
  # Zsh options
  #

  # Move cursor to end of word if a full completion is inserted.
  setopt ALWAYS_TO_END

  setopt NO_CASE_GLOB

  # Don't beep on ambiguous completions.
  setopt NO_LIST_BEEP

  #
  # Completion module options
  #

  # Enable caching
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
}

#
# fzf
#

if (( ${+commands[fd]} )); then
  export FZF_DEFAULT_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -tf'
  export FZF_ALT_C_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -td'
  _fzf_compgen_path() {
    command fd -c always -H --no-ignore-vcs -E .git -tf . "${1}"
  }
  _fzf_compgen_dir() {
    command fd -c always -H --no-ignore-vcs -E .git -td . "${1}"
  }
  export FZF_DEFAULT_OPTS='--ansi --reverse --extended --multi --cycle --bind=ctrl-j:accept,ctrl-u:page-up,ctrl-d:page-down,ctrl-g:toggle-all,ctrl-/:deselect-all,ctrl-q:deselect-all'
  export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
fi

if (( ${+commands[bat]} )); then
  export FZF_CTRL_T_OPTS="--preview 'command bat --line-range :500 {}' ${FZF_CTRL_T_OPTS}"
fi

if (( ${+FZF_DEFAULT_COMMAND} )) export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}

# --------------------
# Module configuration
# --------------------

#
# zsh-autosuggestions
#

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Initialize modules.
source $ZDOTDIR/zinitrc

# Prompt
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_no_bold[white]%}"
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
