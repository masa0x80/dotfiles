_herdr_pool_sync() {
  # _herdr_quiet はプールへ送り込んだ cd の間だけ立つ
  [[ -n "$HERDR_ENV" && -z "$_herdr_quiet" ]] || return
  local pool="${XDG_CONFIG_HOME:-$HOME/.config}/herdr/plugins/pool/pool.zsh"
  [[ -x "$pool" ]] || return
  # プールに送り込む cd 自体もこのフックを踏むが、pool.zsh 側が
  # 直前に同期したパスを覚えているので 2 周目で止まる
  ("$pool" sync "$PWD" &) >/dev/null 2>&1
}
add-zsh-hook chpwd _herdr_pool_sync
