#!/bin/bash

# دریافت پورت اختصاص‌یافته توسط Railway
PORT=${PORT:-2053}

echo "=== Starting PasarGuard Core on Port $PORT ==="

# تنظیم پورت پنل روی پورت Railway
/usr/local/pasarguard/pasarguard port $PORT

# اجرای مستقیم پنل
exec /usr/local/pasarguard/pasarguard run
