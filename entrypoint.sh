#!/bin/sh
set -e

echo "🚀 Starting Tailscale on Railway..."

# فعال‌سازی IP Forwarding
echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.conf
sysctl -p

# اجرای دیمون
tailscaled --tun=userspace-networking --state=/var/lib/tailscale/tailscaled.state &
sleep 5

# احراز هویت و معرفی به‌عنوان Exit Node
if [ -n "$TAILSCALE_AUTHKEY" ]; then
    echo "🔑 Authenticating with Tailscale..."
    if tailscale up --authkey="$TAILSCALE_AUTHKEY" --hostname="railway-app" --advertise-exit-node; then
        echo "✅ Tailscale connected and advertised as exit node!"
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
tail -f /dev/null
