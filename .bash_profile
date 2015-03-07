# Source global definitions
test -r /etc/bashrc && source /etc/bashrc

# start zsh
# ref: http://blog.kenichimaehashi.com/?article=12851025960
if [ -z "${BASH_EXECUTION_STRING}" ]; then
  ZSH='/bin/zsh'
  test -x "${ZSH}" && SHELL="${ZSH}" exec "${ZSH}" -l
fi
