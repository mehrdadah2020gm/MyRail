#!/bin/bash

# جایگزینی پورت ریلیوی اگر ست شده باشه، وگرنه استفاده از 2053
PORT=${PORT:-2053}

echo "=== Installing Pasargad Panel ==="

# نصب پنل پاسارگاد (سورس رسمی)
bash <(curl -Ls https://raw.githubusercontent.com/pasargad-panel/pasargad/main/install.sh)

# تنظیم پورت پنل مطابق با پورت Railway
if [ -f /usr/local/pasargad/pasargad ]; then
    echo "=== Setting Panel Port to $PORT ==="
    # تغییر پورت در دیتابیس یا کانفیگ پنل پاسارگاد
    /usr/local/pasargad/pasargad port $PORT
fi

# روشن نگه داشتن کانتینر و نمایش لوگ‌ها
echo "=== Starting Pasargad Panel Service ==="
/usr/local/pasargad/pasargad run
