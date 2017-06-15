bindkey -e # キーバインドをemacsモードに

autoload -U colors; colors         # プロンプトに色を付ける
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # <C-w> で / まで削除

setopt no_beep              # ビープ音を無効化
setopt no_hup               # シェルを終了してもBG jobにHUPを送らないように
setopt no_flow_control      # フロー制御を無効化
setopt autocd               # cdなしでディレクトリー移動
setopt complete_aliases     # aliasを展開して補完
setopt equals               # =command を絶対パスに展開する
setopt interactive_comments # コマンドラインでも # 以降はコメントと見なす
setopt long_list_jobs       # jobsの出力をデフォルトで jobs -l にする
setopt multios              # 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt numeric_glob_sort    # ファイル名の展開で、辞書順ではなく数値的にソートされるようになる
setopt print_eightbit       # 8ビット目を通すようになり、日本語のファイル名などを見れるようになる
setopt rm_star_wait         # rm * 時に、10秒間反応しなくなり、頭を冷ます時間が与えられる
setopt short_loops          # for, repeat, select, if, function などで簡略文法が使えるようになる
setopt prompt_subst         # 色を使う
unsetopt promptcr           # 文字列末尾に改行コードが無い場合でも表示する

autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
# include words that is at least two characters long
zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'
bindkey '^]' insert-last-word

bindkey "^[[Z" reverse-menu-complete

bindkey "^[^[f" vi-find-next-char
bindkey "^[^[b" vi-find-prev-char
