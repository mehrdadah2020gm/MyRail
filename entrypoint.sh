#!/bin/bash

PORT=${PORT:-2053}

echo "=== Running PasarGuard Installation/Startup ==="

# ابتدا اسکریپت نصب خود پاسارگارد اجرا می‌شود
./pasarguard.sh install --port $PORT || true

# سپس دستور up یا run برای زنده نگه‌داشتن سرویس صدا زده می‌شود
if ./pasarguard.sh up; then
    echo "=== Service started with 'up' ==="
else
    echo "=== Fallback to running pasarguard directly ==="
    ./pasarguard.sh run || tail -f /dev/null
fi
