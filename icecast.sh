#!/bin/sh

# copy default icecast.xml from home dir to /config
if ! [ -e /config/icecast.xml ]; then
  cp /home/icecast.xml /config/icecast.xml
fi
chown -R nobody:users /config

# Set proper UID/GID/UMASK as on host system
# unRAID host uses 99:100 for nobody:users, and a umask of 0000
usermod -u $USER_ID nobody
usermod -g $GROUP_ID nobody
umask $UMASK

# run Icecast
exec /sbin/setuser nobody /usr/bin/icecast2 -c /config/icecast.xml