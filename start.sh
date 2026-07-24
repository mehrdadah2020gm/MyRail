#!/bin/sh

# اجرای tailscaled
tailscaled --state=/tmp/tailscaled.state &

sleep 5

# اتصال
tailscale up \
  --authkey=${TS_AUTHKEY} \
  --advertise-exit-node \
  --accept-dns=false \
  --reset

# زنده نگه داشتن
tail -f /dev/null
