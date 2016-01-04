function direnv-init() {
  echo 'export PATH=$PWD/bin:$PWD/vendor/bin:$PATH' > .envrc && direnv allow
}
alias env_init='direnv-init'
