#!/usr/bin/env bash

dir="${1:-.}"

jj_opts="--no-pager --ignore-working-copy -R $dir"
if jj root $jj_opts &>/dev/null; then
  branch=$(jj log $jj_opts -r @ --no-graph -T 'self.bookmarks().join(", ")' 2>/dev/null)
  if [ -z "$branch" ]; then
    branch=$(jj log $jj_opts -r @ --no-graph -T 'self.change_id().shortest()' 2>/dev/null)
  fi

  conflict=$(jj log $jj_opts -r @ --no-graph -T 'if(self.conflict(), "true", "")' 2>/dev/null)
  empty=$(jj log $jj_opts -r @ --no-graph -T 'if(self.empty(), "true", "")' 2>/dev/null)

  if [ -z "$empty" ]; then
    diff_summary=$(jj diff $jj_opts --summary 2>/dev/null)
    modified=$(echo "$diff_summary" | grep -c '^M' || true)
    added=$(echo "$diff_summary" | grep -c '^A' || true)
    removed=$(echo "$diff_summary" | grep -c '^D' || true)
  fi

  s_clear="#[fg=#{@thm_fg}]"
  s_branch="#[fg=#{@thm_fg},bold]"
  s_staged="#[fg=#{@thm_green},bold]"
  s_conflict="#[fg=#{@thm_red},bold]"
  s_modified="#[fg=#{@thm_yellow},bold]"
  s_clean="#[fg=#{@thm_rosewater},bold]"
  s_deletions="#[fg=#{@thm_red}]"

  out="${s_branch}${branch}${s_clear}"

  if [ -z "$empty" ]; then
    flags=""
    [ "$added" -gt 0 ] 2>/dev/null && flags="${flags} ${s_staged}● ${added}${s_clear}"
    [ "$modified" -gt 0 ] 2>/dev/null && flags="${flags} ${s_modified}✚ ${modified}${s_clear}"
    [ "$removed" -gt 0 ] 2>/dev/null && flags="${flags} ${s_deletions}✖ ${removed}${s_clear}"
    if [[ -z $flags ]]; then
      flags=" ${s_clean}✔${s_clear}"
    fi
    out="${out}${flags}"
  else
    out="${out} ${s_clean}✔${s_clear}"
  fi

  echo "$out"
else
  if git -C "$dir" rev-parse --is-inside-work-tree &>/dev/null; then
    # echo "$(gitmux -cfg "${XDG_CONFIG_HOME:-$HOME/.config}/gitmux/gitmux.conf" "$dir")"
    gitmux -cfg "$HOME/.gitmux.conf" "$dir"
  fi
fi
