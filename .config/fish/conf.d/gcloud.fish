if [ -f $HOME/google-cloud-sdk/path.fish.inc ]
    if type source >/dev/null
        source $HOME/google-cloud-sdk/path.fish.inc
    else
        . $HOME/google-cloud-sdk/path.fish.inc
    end
end
