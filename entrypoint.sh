#!/bin/bash

# استفاده از پورت تخصیص داده شده توسط Railway
PORT=${PORT:-2053}

echo "=== Starting Pasargad Panel on Port $PORT ==="

# تنظیم پورت پنل قبل از اجرا
if [ -f /usr/local/pasargad/pasargad ]; then
    /usr/local/pasargad/pasargad port $PORT
fi

# اجرای مستقیم پنل
exec /usr/local/pasargad/pasargad run
