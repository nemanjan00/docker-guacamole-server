FROM archlinux/base
MAINTAINER nemanjan00 nemanjan00@gmail.com

ENV SQUID_CACHE_DIR=/var/cache/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN pacman -Syu --noconfirm git base-devel

RUN pacman -S --needed --noconfirm sudo
RUN useradd builduser -m # Create the builduser
RUN passwd -d builduser # Delete the buildusers password
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers
RUN sudo -u builduser bash -c 'gpg --recv-keys CD6DBF8EF3B17D3E && cd ~ && git clone https://github.com/nemanjan00/squid.git squid && cd squid && makepkg -si --noconfirm && sudo pacman --noconfirm -U squid-4.8-2-x86_64.pkg.tar.xz && cd .. && rm -rf squid'

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]

