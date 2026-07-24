#!/bin/sh
set -e

echo "🚀 Starting Tailscale on Railway..."

# اجرای دیمون Tailscale در حالت Userspace Networking
/usr/bin/tailscaled --tun=userspace-networking --state=/var/lib/tailscale/tailscaled.state &
sleep 5

# احراز هویت با کلید Auth Key
if [ -n "$TAILSCALE_AUTHKEY" ]; then
    echo "🔑 Authenticating with Tailscale..."
    /usr/bin/tailscale up --authkey="$TAILSCALE_AUTHKEY" --hostname="${TAILSCALE_HOSTNAME:-railway-app}"
    echo "✅ Tailscale connected successfully!"
    
    # نمایش IP اختصاصی دستگاه در شبکه Tailscale
    /usr/bin/tailscale ip
else
    echo "❌ ERROR: TAILSCALE_AUTHKEY environment variable not set."
    exit 1
fi

# نگه داشتن کانتینر در حالت اجرا
echo "📡 Tailscale is running. Keeping container alive..."
tail -f /dev/null
