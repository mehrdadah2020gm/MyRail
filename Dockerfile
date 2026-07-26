FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# نصب ابزارهای پایه و ضروری برای اجرای pasarguard.sh
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    sudo \
    wget \
    procps \
    net-tools \
    sqlite3 \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# کلون کردن سورس دقیق پروژه
RUN git clone https://github.com/PasarGuard/scripts.git . && \
    chmod +x pasarguard.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
