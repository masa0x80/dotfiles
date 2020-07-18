function browse
    argparse 'i/incognito' 'p/profile=' -- $argv || return
    set url $argv

    if set -lq _flag_incognito
        set profile (string replace -r '^=' '' -- $_flag_profile)
        open -na 'Vivaldi' --args --incognito \
            --user-data-dir=$HOME/Library/Application\ Support/Vivaldi/aws-vault/$profile \
            $url
    else
        open -na 'Vivaldi' $url
    end
end
