function mntXU4 () {
    mkdir -p /Volumes/XU4
    pw=$(security find-internet-password -wl XU4)
    server_ip=$(security find-internet-password -l XU4 | grep -E "(?:\d{1,3}\.){3}\d{1,3}" -o)
    mount -t afp afp://yadunut:$pw@$server_ip/XU4-Files /Volumes/XU4/
}

function umntXU4 () {
    umount /Volumes/XU4
}
