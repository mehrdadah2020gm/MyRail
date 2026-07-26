#!/bin/bash

# دریافت پورت از Railway (دیفالت 2053)
PORT=${PORT:-2053}

echo "=== Starting PasarGuard Web Service on Port $PORT ==="

# پیدا کردن فایل اصلی اجرای FastAPI/Python داخل سورس
if [ -f "main.py" ]; then
    exec uvicorn main:app --host 0.0.0.0 --port $PORT
elif [ -f "app/main.py" ]; then
    exec uvicorn app.main:app --host 0.0.0.0 --port $PORT
elif [ -f "pasarguard.py" ]; then
    exec python3 pasarguard.py --port $PORT
else
    echo "Files in repository:"
    ls -la
    echo "Could not find main entry point automatically."
    exit 1
fi
