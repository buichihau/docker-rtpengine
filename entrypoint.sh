#!/bin/bash
set -e

PATH=/usr/local/bin:$PATH

MY_IP="$MY_IP"

sed -i -e "s/MY_IP/$MY_IP/g" /etc/rtpengine.conf

if [ "$1" = 'rtpengine' ]; then
  shift
  exec rtpengine --config-file /etc/rtpengine.conf  "$@"
fi

exec "$@"