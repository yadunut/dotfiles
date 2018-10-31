#!/bin/bash

set -eu -o pipefail

backupPath="/usr/local/bin/backup"
daemonPath="$HOME/Library/LaunchAgents/com.yadunut.backup.plist"

launchctl unload -w "$daemonPath"
echo "Unloaded Daemon"

if rm "$backupPath" &>/dev/null; then
    echo "Successfully uninstalled $backupPath"
else
    echo "$backupPath not found"
fi

if rm "$daemonPath" &>/dev/null; then
    echo "Successfully uninstalled $daemonPath"
else
    echo "$daemonPath not found"
fi
