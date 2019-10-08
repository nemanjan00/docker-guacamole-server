FROM archlinux/base
MAINTAINER nemanjan00 nemanjan00@gmail.com

ENV SQUID_CACHE_DIR=/var/cache/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

#RUN pacman -Syu --noconfirm squid

RUN pacman -S --needed --noconfirm sudo
RUN useradd builduser -m # Create the builduser
RUN passwd -d builduser # Delete the buildusers password
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers # Allow the builduser passwordless sudo
RUN sudo -u builduser bash -c 'cd ~ && git clone https://github.com/nemanjan00/squid.git squid && cd squid && makepkg -si --noconfirm && sudo pacman -U **.pkg.tar.gz && cd .. && rm -rf squid'

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]

