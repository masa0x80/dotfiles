# Skip loading config if already login
status is-login || exit

type -qa open && abbr -a o open

type -qa mycli && abbr -a mysql mycli
type -qa pgcli && abbr -a psql pgcli

abbr -a , l
abbr -a ,, la
type -qa exa && abbr -a tree 'exa -T'

type -qa rg && abbr -a g 'rg --hidden'
type -qa bat && abbr -a cat bat

type -qa asdf && abbr -a aoeu asdf

abbr -a tailf 'tail -f'
abbr -a diff 'diff -u'
abbr -a watch 'watch -n 0.5'
abbr -a mkdir 'mkdir -p'

abbr -a md mkdir
abbr -a rd rmdir
abbr -a rf 'rm -rf'

abbr -a vim vi

abbr -a g 'rg --hidden'

# ssh {{{
if test -e $HOME/.ssh/config
    abbr -a ssh_config 'eval $EDITOR ~/.ssh/config'
    abbr -a sconfig 'eval $EDITOR ~/.ssh/config'
    abbr -a sconf 'eval $EDITOR ~/.ssh/config'
end
# }}}

# git {{{
abbr -a ga 'git add'
abbr -a gaa 'git add --all'

abbr -a gb 'git branch'
abbr -a gba 'git branch -a'
abbr -a gbr 'git branch --remote'

abbr -a gc 'git commit -v'
abbr -a gc! 'git commit -v --amend'
abbr -a gco 'git checkout'

abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'

abbr -a gf 'git fetch'

abbr -a gfx 'git fixup'

abbr -a lg 'git fzf show'

abbr -a gl tig
abbr -a glg 'git log --stat --color'
abbr -a glgp 'git log --stat --color -p'
abbr -a glog 'git log --oneline --decorate --color --graph'

abbr -a gm 'git merge --no-ff'

abbr -a gp 'git push'
abbr -a gpull git_pull_and_prune
abbr -a gpush 'git push origin (git_current_branch)'
abbr -a gpush! 'git push --force-with-lease origin (git_current_branch)'

abbr -a grb 'git rebase'
abbr -a grbm 'git rebase master'

abbr -a grba 'git rebase --abort'
abbr -a grbc 'git rebase --continue'
abbr -a grbi 'git rebase -i'
abbr -a grbs 'git rebase --skip'

abbr -a gri 'git rebase -i (git fzf)'

abbr -a gsh 'git show'
abbr -a gst 'git status -sb'
abbr -a gts 'git tag -s'

abbr -a br 'git switch -c'
abbr -a review 'git review GH'
# }}}

# vagrant {{{
abbr -a vdf 'vagrant destroy -f'
abbr -a vst 'vagrant global-status'
# }}}

# ruby {{{
abbr -a c 'rails c'
abbr -a s 'rails s -p $RAILS_SERVER_PORT'

abbr -a db 'rails db'
abbr -a rr 'rails routes'

abbr -a t rspec
abbr -a ss 'spring stop'

abbr -a be 'bundle exec'
abbr -a bi "bundle config set path 'vendor/bundle'; bundle binstubs --path=vendor/bin; bundle install"
abbr -a bil "bundle config set path 'vendor/bundle'; bundle binstubs --path=vendor/bin; bundle install --local"

abbr -a solargraph_init "solargraph download-core; solargraph bundle; solargraph config"
# }}}

# docker {{{
abbr -a dcu 'dc up -d'
abbr -a dcd 'dc down'
# }}}

abbr -a a 'aws-vault exec $AWS_PROFILE --'

abbr -a da 'direnv allow'

abbr -a Get 'ghq get'

abbr -a sb scrapbook
