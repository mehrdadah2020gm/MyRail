# استفاده از یه تصویر پایه سبک (Alpine) برای کاهش حجم [citation:2]
FROM alpine:latest

# نصب ابزارهای مورد نیاز و خود Tailscale [citation:1][citation:4]
RUN apk add --no-cache curl iptables iproute2 \
    && curl -fsSL https://tailscale.com/install.sh | sh

# پوشه‌ای برای ذخیره وضعیت Tailscale (برای حفظ شناسه دستگاه)
RUN mkdir -p /var/lib/tailscale /data

# کپی کردن اسکریپت ورودی به کانتینر
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
