#!/bin/bash

rsync \
    --archive \
    --progress \
    --human-readable \
    --exclude node_modules \
    --exclude .DS_Store \
    ~/dev \
    ~/Documents \
    ~/Desktop \
    REDACTED@REDACTED:/mnt/md0/backups/macbookpro
