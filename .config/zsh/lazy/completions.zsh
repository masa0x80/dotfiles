# Autoload functions
fpath=($ZDOTDIR/functions(N-/) $fpath)
for config_file ($ZDOTDIR/functions/*(N)) autoload $(basename "$config_file")

#
# Completion enhancements
#

[[ ${TERM} != dumb ]] && () {
  zdumpfile=${ZDOTDIR:-${HOME}}/.zcompdump
  autoload -Uz compinit && compinit -C -d ${zdumpfile}
  autoload -Uz bashcompinit && bashcompinit

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
}
