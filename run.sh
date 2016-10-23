#! /usr/bin/env bash

set -e

#authorized_keys=/root/.ssh/authorized_keys
authorized_keys=/etc/ssh/authorized_keys/root

if [ "$1" = '' ]; then
  mkdir -p $( dirname "$authorized_keys" )
  echo "$SSH_KEY" > "$authorized_keys"
  chmod 600 "$authorized_keys"
  /usr/sbin/sshd -D
else
  exec "$@"
fi
