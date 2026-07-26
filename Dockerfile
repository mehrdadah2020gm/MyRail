FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# نصب ابزارهای مورد نیاز
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# دریافت آخرین Binary رسمی PasarGuard مستقیماً از گیت‌هاب پروژه
RUN curl -sL https://github.com/PasarGuard/PasarGuard/releases/latest/download/pasarguard-linux-amd64.tar.gz -o /tmp/pasarguard.tar.gz \
    && mkdir -p /usr/local/pasarguard \
    && tar -zxvf /tmp/pasarguard.tar.gz -C /usr/local/pasarguard \
    && rm /tmp/pasarguard.tar.gz \
    && chmod +x /usr/local/pasarguard/pasarguard

WORKDIR /usr/local/pasarguard

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
