%w(
  github.com/direnv/direnv
  github.com/masa0x80/mdv/...
  github.com/mackerelio/mkr
  github.com/mattn/qq/...
  github.com/motemen/ghq
  github.com/monochromegane/the_platinum_searcher/cmd/pt
  github.com/peco/peco/...
).each do |repo|
  execute "go get #{ENV.fetch('GO_GET_OPTION', '')} #{repo}"
end
