FROM alpine:latest

RUN apk add --no-cache curl iptables iproute2

# نصب tailscale
RUN curl -fsSL https://tailscale.com/install.sh | sh

# ساخت اسکریپت اجرا
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
