if exists('b:current_syntax')
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'rspec-reult'
endif

syntax case match

syntax match RSpecGreen /^\.*$/
syntax match RSpecRed   /^[F.]*F[F.]*$/
syntax match RSpecGreen /^.* 0 failure.*$/
syntax match RSpecRed   /^.* [1-9][0-9]* failure.*$/

highlight RSpecGreen ctermfg=114 guifg=#98c379
highlight RSpecRed ctermfg=204 guifg=#e06c75

let b:current_syntax = 'rspec-result'

if main_syntax == 'rspec-result'
  unlet main_syntax
endif
