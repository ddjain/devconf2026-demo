#!/bin/sh
set -e

# Random countdown: 2, 5, or 20 seconds
case $((RANDOM % 3)) in 0) n=2;; 1) n=5;; 2) n=20;; esac
i=$n
while [ $i -ge 1 ]; do
  echo $i
  sleep 1
  i=$((i-1))
done
echo "starting"

export POD_NAME="${POD_NAME:-$HOSTNAME}"
INSTANCE_ID=$(cat /proc/sys/kernel/random/uuid 2>/dev/null || echo "id-$$-$RANDOM")
export NODE_NAME="${NODE_NAME:-$INSTANCE_ID}"

envsubst < /usr/share/nginx/html/index.html.template > /usr/share/nginx/html/index.html
envsubst < /usr/share/nginx/html/status.json.template > /usr/share/nginx/html/status.json

exec nginx -g "daemon off;"
