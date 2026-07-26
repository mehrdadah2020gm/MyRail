FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# نصب مستقیم curl و پیش‌نیازهای ضروری
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    sqlite3 \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# دانلود و استخراج فایل پاسارگاد تنها با استفاده از curl
RUN LATEST_URL=$(curl -s https://api.github.com/repos/pasargad-panel/pasargad/releases/latest | grep "browser_download_url.*linux-amd64.tar.gz" | cut -d : -f 2,3 | tr -d \") && \
    curl -sL "$LATEST_URL" -o /tmp/pasargad.tar.gz && \
    mkdir -p /usr/local/pasargad && \
    tar -zxvf /tmp/pasargad.tar.gz -C /usr/local/pasargad && \
    rm /tmp/pasargad.tar.gz

WORKDIR /usr/local/pasargad

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
