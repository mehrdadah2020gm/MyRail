#!/bin/sh
set -e

echo "🚀 Starting Tailscale on Railway..."

# اجرای دیمون Tailscale در حالت Userspace Networking
tailscaled --tun=userspace-networking --state=/var/lib/tailscale/tailscaled.state &
sleep 5

# احراز هویت
if [ -n "$TAILSCALE_AUTHKEY" ]; then
    echo "🔑 Authenticating with Tailscale..."
    tailscale up --authkey="$TAILSCALE_AUTHKEY" --hostname="${TAILSCALE_HOSTNAME:-railway-app}"
    echo "✅ Tailscale connected successfully!"
    tailscale ip
else
    echo "❌ ERROR: TAILSCALE_AUTHKEY environment variable not set."
    exit 1
fi

echo "📡 Tailscale is running. Keeping container alive..."
tail -f /dev/null
