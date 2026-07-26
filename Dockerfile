FROM ubuntu:22.04

# جلوگیری از پرسش‌های تعاملی هنگام نصب پکیج‌ها
ENV DEBIAN_FRONTEND=noninteractive

# نصب پیش‌نیازهای ضروری
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    sudo \
    systemctl \
    ca-certificates \
    net-tools \
    &> /dev/null && \
    rm -rf /var/lib/apt/lists/*

# کپی کردن اسکریپت استارت
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# اجرای اسکریپت اصلی
ENTRYPOINT ["/entrypoint.sh"]
