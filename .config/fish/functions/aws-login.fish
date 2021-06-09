function aws-login
    argparse 'i/incognito' -- $argv || return

    set profile $argv
    if not count $profile >/dev/null
        aws-vault list --profiles | fzf +m | read profile
    end
    if count $profile >/dev/null
        set url (aws-vault login profile --stdout)
        if set -lq _flag_incognito
            set profile (string replace -r '^=' '' -- $_flag_profile)
            browse -i -p $profile $url
        else
            browse $url
        end
    else
        echo 'usage: aws-login <profile>'
    end
end
