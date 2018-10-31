#!/bin/bash

# Exit Codes
# 0  -  Successfully backed up
# 2  -  Failed. No Internet connection
# *  -  Errors from duplicity

set -eu -o pipefail

function displayNotification() {
    echo "$1"
    osascript -e "display notification \"$1\" with title \"Backup\""
}

function finish() {
    local exit_value=$?
    case $exit_value in
    0)
        displayNotification "Successfully backed up"
        rm /tmp/backup.log
        ;;
    2)
        displayNotification "Failed. Not connected to internet"
        ;;
    *)
        displayNotification "Failed with Exit code $exit_value"
        ;;

    esac
}

trap finish EXIT

if ! (ping -q -c 1 -W 1 8.8.8.8 &>/dev/null); then
    # No internet connection
    exit 2
fi

# Source GPG password, rsync paths
HOME="/Users/yadunandprem"
source "$HOME/.duplicity/.env_variables.conf"

# I have an issue where I can't SSH to server using its domain name if I'm in the same network
# eg. I can SSH to server using username@ip but i cant ssh to the same server using @username@domain.com
# The following checks whether I'm at home, and uses the correct SSH Params
SSID="$(
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I |
        awk '/ SSID/ {print substr($0, index($0, $2))}'
)"

if [[ "$SSID" == "$HOME_SSID" ]]; then
    RSYNC="$HOME_SERVER"
else
    RSYNC="$SERVER"
fi

/usr/local/bin/duplicity \
    --verbosity info \
    --log-file "/tmp/backup.log" \
    --encrypt-key "$GPG_KEY" \
    --full-if-older-than 7D \
    --include ~/dev \
    --include ~/Desktop \
    --include ~/Documents \
    --include ~/Downloads \
    --exclude '**' \
    ~ \
    "$RSYNC"

unset GPG_KEY
unset HOME_SERVER
unset SERVER
unset HOME_SSID
unset PASSPHRASE
unset SIGN_PASSPHRASE
