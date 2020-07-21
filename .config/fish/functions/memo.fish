function memo
    not set -q SCRAPBOOK_DIR && set SCRAPBOOK_DIR $HOME/.scrapbook
    set -l file_path (string escape -n $SCRAPBOOK_DIR/memo/(current_dir _))
    set -l dir (dirname $file_path)
    test -d $dir || mkdir -p $dir
    eval $EDITOR $file_path
end
