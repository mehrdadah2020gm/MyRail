#!/bin/bash

PORT=${PORT:-2053}

echo "=== Searching for PasarGuard Application Executables ==="

# جستجو برای یافتن فایل اجرایی اصلی پروژه
PASAR_BIN=$(find /app -name "pasarguard" -type f -o -name "PasarGuard" -type f | head -n 1)

if [ -n "$PASAR_BIN" ]; then
    echo "Found executable at: $PASAR_BIN"
    chmod +x "$PASAR_BIN"
    # تنظیم پورت و اجرای سرویس
    "$PASAR_BIN" port $PORT || true
    exec "$PASAR_BIN" run
else
    echo "Executable not found directly, checking repository structure:"
    ls -R /app
    # زنده نگه داشتن کانتینر برای بررسی لاگ‌های پوشه
    tail -f /dev/null
fi
