if exists('b:current_syntax')
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'jest-result'
endif

syntax case match

syntax match JestRed /^FAIL /
syntax match JestRed / ✕ /
syntax match JestRed / > /
syntax match JestRed / ^$/
syntax match JestGreen /^PASS /
syntax match JestGreen / ✓ /
syntax match JestGreen /expected/
syntax match JestGreen /Expected: .*/
syntax match JestRed /received/
syntax match JestRed /Received: .*/
syntax match JestGreen /[0-9]* passed/
syntax match JestRed /[0-9]* failed/
syntax match JestYellow / ○ /
syntax match JestYellow /[0-9]* skipped/

highlight JestGreen ctermfg=114 guifg=#98c379
highlight JestYellow ctermfg=235 guifg=#e5c07b
highlight JestRed ctermfg=204 guifg=#e06c75

let b:current_syntax = 'jest-result'

if main_syntax == 'jest-result'
  unlet main_syntax
endif

