; extends

; 本体の injections.scm は info_string をそのまま injections.language に渡すので
; コードフェンスの言語名エイリアスを解決する
((fenced_code_block
   (info_string
     (language) @_lang)
   (code_fence_content) @injection.content)
  (#any-of? @_lang "sh" "shell" "console" "zsh")
  (#set! injection.language "bash"))

((fenced_code_block
   (info_string
     (language) @_lang)
   (code_fence_content) @injection.content)
  (#any-of? @_lang "js" "mjs" "cjs")
  (#set! injection.language "javascript"))

((fenced_code_block
   (info_string
     (language) @_lang)
   (code_fence_content) @injection.content)
  (#any-of? @_lang "ts")
  (#set! injection.language "typescript"))

((fenced_code_block
   (info_string
     (language) @_lang)
   (code_fence_content) @injection.content)
  (#any-of? @_lang "py")
  (#set! injection.language "python"))

((fenced_code_block
   (info_string
     (language) @_lang)
   (code_fence_content) @injection.content)
  (#any-of? @_lang "rb")
  (#set! injection.language "ruby"))

((fenced_code_block
   (info_string
     (language) @_lang)
   (code_fence_content) @injection.content)
  (#any-of? @_lang "yml")
  (#set! injection.language "yaml"))

((fenced_code_block
   (info_string
     (language) @_lang)
   (code_fence_content) @injection.content)
  (#any-of? @_lang "tf")
  (#set! injection.language "terraform"))

((fenced_code_block
   (info_string
     (language) @_lang)
   (code_fence_content) @injection.content)
  (#any-of? @_lang "md")
  (#set! injection.language "markdown"))
