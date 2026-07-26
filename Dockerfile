FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# نصب پیش‌نیازهای سیستم و گیت
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# کلون کردن مستقیم سورس پاسارگارد از گیت‌هاب رسمی
WORKDIR /app
RUN git clone https://github.com/PasarGuard/scripts.git .

# نصب وابستگی‌های پایتون پروژه (اگر requirements وجود داره)
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi
RUN pip install --no-cache-dir uvicorn fastapi gunicorn

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
