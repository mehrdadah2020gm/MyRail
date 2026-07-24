FROM alpine:latest

# نصب ابزارهای مورد نیاز و خود Tailscale از مخزن رسمی
RUN apk add --no-cache curl iptables iproute2 tailscale

# ایجاد پوشه وضعیت
RUN mkdir -p /var/lib/tailscale /data

# کپی اسکریپت ورودی
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
