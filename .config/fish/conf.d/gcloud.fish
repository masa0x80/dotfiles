# Skip loading config if already login
status is-login || exit

set -l gcloud_path /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
if test -f $gcloud_path
    source $gcloud_path
end
