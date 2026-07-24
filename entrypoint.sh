#!/bin/sh
set -e

echo "🚀 Starting Tailscale on Railway..."

# فعال‌سازی IP Forwarding
echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.conf
sysctl -p

# اجرای دیمون
tailscaled --tun=userspace-networking --state=/var/lib/tailscale/tailscaled.state &
sleep 5

# احراز هویت با گزینه‌های پایدارتر
if [ -n "$TAILSCALE_AUTHKEY" ]; then
    echo "🔑 Authenticating with Tailscale..."
    if tailscale up \
        --authkey="$TAILSCALE_AUTHKEY" \
        --hostname="railway-app" \
        --advertise-exit-node \
        --exit-node-allow-lan-access \
        --reset; then
        echo "✅ Tailscale connected successfully!"
        tailscale ip
    else
        echo "❌ Authentication failed. Exiting..."
        exit 1
    fi
else
    echo "❌ ERROR: TAILSCALE_AUTHKEY environment variable not set."
    exit 1
fi

echo "📡 Tailscale is running. Keeping container alive..."

# چک کردن سلامت اتصال هر 30 ثانیه
while true; do
    if ! tailscale status | grep -q "online"; then
        echo "⚠️ Connection lost! Restarting..."
        exit 1
    fi
    sleep 30
done
