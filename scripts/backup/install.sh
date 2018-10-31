#!/bin/bash

set -eu -o pipefail

SCRIPTPATH="$(
    cd "$(dirname "$0")"
    pwd -P
)"

backupFile="$SCRIPTPATH/backup.sh"
backupPath="/usr/local/bin/backup"
daemonFile="$SCRIPTPATH/com.yadunut.backup.plist"
daemonPath="$HOME/Library/LaunchAgents/com.yadunut.backup.plist"

ln -s "$backupFile" "$backupPath"
echo "Symlinked backup.sh to $backupPath"

ln -s "$daemonFile" "$daemonPath"
echo "Symlinked com.yadunut.backup.plist to $daemonPath"

launchctl load -w "$daemonPath"
echo "Loaded daemon"
