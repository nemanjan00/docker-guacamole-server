FROM archlinux/base
MAINTAINER nemanjan00 nemanjan00@gmail.com

ENV SQUID_CACHE_DIR=/var/cache/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN pacman -Syu --noconfirm squid

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]

