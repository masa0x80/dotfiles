# Source global definitions
test -r /etc/bashrc && source /etc/bashrc

export PATH=$PATH:$HOME/.local/bin:$HOME/bin

# start fish
# ref: http://blog.kenichimaehashi.com/?article=12851025960
if [ -z "${BASH_EXECUTION_STRING}" ]; then
  SHELL=`which fish`
  test -x "${SHELL}" && exec "${SHELL}" -l
fi
