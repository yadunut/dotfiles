function mntXU4 () {
    mkdir -p /Volumes/XU4
    pw=$(security find-internet-password -wl XU4)
    server_ip=$(security find-internet-password -l XU4 | grep srvr | sed s/srvr// | sed s/\"//g | sed s/\<blob\>=//g| tr -d " \t\n\r" )
    mount -t afp afp://yadunut:$pw@$server_ip/XU4-Files /Volumes/XU4/
}

function umntXU4 () {
    umount /Volumes/XU4
}
