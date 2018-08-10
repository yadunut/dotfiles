function mntXU4 () {
    mkdir -p /tmp/XU4
    pw=$(security find-internet-password -wl XU4)
    server_ip=$(security find-internet-password -l XU4 | grep -E "(?:\d{1,3}\.){3}\d{1,3}" -o)
    mount -t afp afp://yadunut:$pw@$server_ip:8080/XU4-Files /tmp/XU4/
}

function umntXU4 () {
    umount /Volumes/XU4
}

function mntXU4TM () {
    mkdir -p /Volumes/XU4-Time-Machine
    pw=$(security find-internet-password -wl XU4)
    server_ip=$(security find-internet-password -l XU4 | grep -E "(?:\d{1,3}\.){3}\d{1,3}" -o)
    mount -t afp afp://yadunut:$pw@$server_ip:8080/XU4-Time-Machine /Volumes/XU4-Time-Machine/
}

function umntXU4TM () {
    umount /Volumes/XU4-Time-Machine
}
