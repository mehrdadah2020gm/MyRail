FROM alpine:latest

# نصب ابزارهای مورد نیاز
RUN apk add --no-cache curl iptables iproute2

# دانلود باینری مستقل Tailscale (بدون وابستگی به سیستم init)
RUN curl -fsSL -o /usr/bin/tailscale https://pkgs.tailscale.com/stable/linux/tailscale_amd64 \
    && curl -fsSL -o /usr/bin/tailscaled https://pkgs.tailscale.com/stable/linux/tailscaled_amd64 \
    && chmod +x /usr/bin/tailscale /usr/bin/tailscaled

# پوشه ذخیره وضعیت Tailscale
RUN mkdir -p /var/lib/tailscale /data

# کپی اسکریپت ورودی
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
