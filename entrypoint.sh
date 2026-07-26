#!/bin/bash

PORT=${PORT:-2053}

echo "=== Starting PasarGuard Script on Port $PORT ==="

# اجرای مستقیم اسکریپت اصلی پاسارگارد با ورودی‌های لازم
# اگر اسکریپت دستور run یا start داره ازش استفاده می‌کنیم
if [ -f "./pasarguard.sh" ]; then
    ./pasarguard.sh @ port $PORT || true
    exec ./pasarguard.sh @ run
else
    echo "pasarguard.sh not found!"
    exit 1
fi
