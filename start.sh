#!/bin/sh

# اجرای tailscaled
tailscaled &

sleep 5

# اتصال به اکانتت
tailscale up \
  --authkey=${TS_AUTHKEY} \
  --advertise-exit-node \
  --accept-dns=false

# نگه داشتن کانتینر
tail -f /dev/null
