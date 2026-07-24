#!/bin/sh
set -e

# اجرای دیمون Tailscale در حالت Userspace Networking
# این روش برای محیط‌های محدود مثل Railway ضروری است [citation:2][citation:11]
tailscaled --tun=userspace-networking --state=/var/lib/tailscale/tailscaled.state &
sleep 5

# احراز هویت با استفاده از کلید Auth Key که از Railway به عنوان متغیر محیطی دریافت می‌شود [citation:1][citation:4][citation:6]
if [ -n "$TAILSCALE_AUTHKEY" ]; then
    tailscale up --authkey="$TAILSCALE_AUTHKEY" --hostname="${TAILSCALE_HOSTNAME:-railway-app}"
    echo "Tailscale connected!"
else
    echo "ERROR: TAILSCALE_AUTHKEY environment variable not set."
    exit 1
fi

# جلوگیری از اتمام اسکریپت و بسته شدن کانتینر
tail -f /dev/null
