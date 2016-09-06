#!/bin/sh

# Mount default VM share
# Workaround for https://github.com/docker/machine/issues/2050

sudo umount /Users &>/dev/null || :
sudo sh -c "mount --bind /mnt/hgfs/Users /Users \
            || /etc/rc.d/vbox \
            || :" &>/dev/null

# User tce mirror
echo "http://distro.ibiblio.org/tinycorelinux" > /opt/tcemirror

# Install and run avahi daemon
tce-load -w -i avahi.tcz
sudo sed -i 's/#enable-dbus=yes/enable-dbus=no/g' /usr/local/etc/avahi/avahi-daemon.conf
sudo /usr/local/sbin/avahi-daemon -c || sudo /usr/local/sbin/avahi-daemon -D
