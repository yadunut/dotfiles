#!/bin/bash
case $1 in
home)
    RSYNC=rsync://yadunut@10.0.0.4//mnt/md0/backups/macbookpro
    ;;
*)
    RSYNC=rsync://yadunut@home.yadunut.com//mnt/md0/backups/macbookpro
    ;;
esac

/usr/local/bin/duplicity incr \
    --encrypt-key 940AFD10 \
    --verbosity 9 \
    --include ~/dev \
    --include ~/Desktop \
    --include ~/Documents \
    --include ~/Downloads \
    --exclude '**' \
    ~ \
    $RSYNC
