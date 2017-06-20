function kst
  __select_target_host | read -l target_host
  set -q target_host; or return

  echo "knife solo prepare $target_host $argv; \
    and knife solo cook $target_host $argv" \
    | string replace -a -r '\s*;\s+' '; ' | read -l cmd
  commandline $cmd
end
