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

# 履歴
HISTFILE="$HOME/.zhistory"                     # history保存ファイル
HISTSIZE=10000                                 # メモリーに保存されるhistory件数
SAVEHIST=10000                                 # 保存されるhistory件数
bindkey '^P' history-beginning-search-backward # <C-p>でhistoryをbackward検索
bindkey '^N' history-beginning-search-forward  # <C-n>でhistoryをforward検索
setopt hist_find_no_dups                       # history検索中に重複を飛ばす
setopt hist_ignore_all_dups                    # 同じコマンドの場合は古いものを削除する
setopt hist_ignore_space                       # スペースで始まるものは保存しない
setopt hist_reduce_blanks                      # 余分な空白を削除する
setopt hist_expire_dups_first                  # 古いhistoryが削除されるときったくに同じ行があれば優先削除
setopt append_history                          # 複数のzshを並列実行する場合に上書きせず追記する
setopt share_history                           # プロセス間でhistoryを共有
setopt hist_no_store                           # history (fc -l) コマンドをヒストリリストから取り除く。

# 補完
autoload -U compinit; compinit # 補完を有効に
setopt menu_complete           # 補完候補が複数ある時、一覧表示 (auto_list) せず、すぐに最初の候補を補完する
setopt list_types              # auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt auto_list               # 補完候補を一覧表示
setopt auto_menu               # <Tab>で補完
setopt auto_param_keys         # カッコ対応などを自動で補完
setopt auto_param_slash        # 最後がディレクトリー名の場合に / を追加
setopt mark_dirs               # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt magic_equal_subst       # コマンドラインの引数で --prefix=/usr などの = 以降でも補完する
setopt brace_ccl               # {a-c} を a b c に展開する

zstyle ':completion:*:default' menu select=1                                        # 補完候補をカーソルで選べるように
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z} r:|[-_.]=**' # -_. の前は末尾に * を付けていい感じに補完する

# Antigen
source $HOME/.zsh/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle https://github.com/mollifier/anyframe
antigen bundle git
antigen theme ys
antigen apply

# カスタム設定を読み込む
for CONFIG_FILE ($HOME/.zsh/custom/*.zsh(N)); do
  source $CONFIG_FILE
done

CONFIG_FILE="$HOME/.zsh/alias.zsh"  && test -r $CONFIG_FILE && source $CONFIG_FILE # エイリアス設定の読み込み

# OSごとの設定の読み込み
for CONFIG_FILE ($HOME/.zsh/os/$(uname | tr A-Z a-z)/*.zsh(N)); do
  source $CONFIG_FILE
done

CONFIG_FILE="$HOME/.zshrc.local" && test -r $CONFIG_FILE && source $CONFIG_FILE # 環境ローカルの設定の読み込み
unset CONFIG_FILE
