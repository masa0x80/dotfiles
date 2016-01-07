HISTFILE="$HOME/.zhistory"                     # history保存ファイル
HISTSIZE=1000000                               # メモリーに保存されるhistory件数
SAVEHIST=1000000                               # 保存されるhistory件数
bindkey '^P' history-beginning-search-backward # <C-p>でhistoryをbackward検索
bindkey '^N' history-beginning-search-forward  # <C-n>でhistoryをforward検索
setopt hist_find_no_dups                       # history検索中に重複を飛ばす
setopt hist_ignore_all_dups                    # 同じコマンドの場合は古いものを削除する
setopt hist_ignore_space                       # スペースで始まるものは保存しない
setopt hist_expire_dups_first                  # 古いhistoryが削除されるときったくに同じ行があれば優先削除
setopt append_history                          # 複数のzshを並列実行する場合に上書きせず追記する
setopt share_history                           # プロセス間でhistoryを共有
setopt hist_no_store                           # history (fc -l) コマンドをヒストリリストから取り除く。
