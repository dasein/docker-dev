#!/bin/sh

# TODO(hpfennig) Not sure if we want to do nfs.
#
# sudo umount /Users
# sudo /usr/local/etc/init.d/nfs-client start
# sleep 1
# sudo mount.nfs 192.168.99.1:/Users /Users -v -o rw,async,noatime,rsize=32768,wsize=32768,proto=udp,udp,nfsvers=3

# Boot2docker machine broke vmwarefusion shares in 1.8.3
# Temporary fix to make relative paths work
rmdir /Users 2>/dev/null && ln -s /mnt/hgfs/Users /Users || :

# User reliable tce repo
echo "http://distro.ibiblio.org/tinycorelinux" > /opt/tcemirror

# Install and run avahi daemon
tce-load -w -i avahi.tcz
sudo sed -i 's/#enable-dbus=yes/enable-dbus=no/g' /usr/local/etc/avahi/avahi-daemon.conf
sudo /usr/local/sbin/avahi-daemon -c || sudo /usr/local/sbin/avahi-daemon -D
