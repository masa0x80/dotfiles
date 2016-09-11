dinit() {
  echo 'export PATH=$PWD/bin:$PWD/vendor/bin:$PATH' > .envrc && direnv allow
}
