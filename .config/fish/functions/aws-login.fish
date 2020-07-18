function aws-login
    argparse 'i/incognito' -- $argv || return

    set profile $argv
    if not count $profile >/dev/null
        aws-vault list --profiles | egrep "^aws-vault" | string sub -s 11 | fzf +m | read profile
    end
    if count $profile >/dev/null
        set url (aws-vault login aws-vault.$profile --stdout)
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
