# Autoload functions
fpath=($ZDOTDIR/functions(N-/) $fpath)
for config_file ($ZDOTDIR/functions/*(N)) autoload $(basename "$config_file")
