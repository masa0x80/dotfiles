function scrapbook_dir
    not set -q SCRAPBOOK_DIR && set -gx SCRAPBOOK_DIR $HOME/.scrapbook
    set -l dir ''
    test "$argv" = '' || set dir "$argv/"
    set -l dir_path (string escape -n $SCRAPBOOK_DIR/$dir)
    test -d $dir_path || mkdir -p $dir_path
    echo $dir_path
end
