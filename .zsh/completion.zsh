# 補完
autoload -U compinit; compinit # 補完を有効に
setopt menu_complete           # 補完候補が複数ある時、一覧表示 (auto_list) せず、すぐに最初の候補を補完する
setopt list_types              # auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt always_last_prompt      # 補完候補を一覧表示
setopt auto_list               # 補完候補をリストアップ
setopt auto_menu               # <Tab>で補完
setopt auto_param_keys         # カッコ対応などを自動で補完
setopt auto_param_slash        # 最後がディレクトリー名の場合に / を追加
setopt mark_dirs               # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt magic_equal_subst       # コマンドラインの引数で --prefix=/usr などの = 以降でも補完する
setopt brace_ccl               # {a-c} を a b c に展開する
setopt correct                 # スペルミスを訂正する

zstyle ':completion:*:default' menu select=2                                        # 補完候補をカーソルで選べるように; 候補が2つ以上の場合は即補完
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z} r:|[-_.]=**' # -_. の前は末尾に * を付けていい感じに補完する

# 色設定
if (( $+commands[dircolors] )); then
  eval $(dircolors $HOME/.zsh/misc/dircolors.ansi-dark)
elif (( $+commands[gdircolors] )); then
  eval $(gdircolors $HOME/.zsh/misc/dircolors.ansi-dark)
fi
if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# Source: https://github.com/junegunn/fzf/blob/master/shell/completion.zsh
load_file $HOME/.zsh/misc/fzf_completion.zsh

# Source: https://github.com/simonwhitaker/gibo/blob/master/gibo-completion.zsh
load_file $HOME/.zsh/misc/gibo-completion.zsh
