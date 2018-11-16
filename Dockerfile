FROM finalduty/archlinux:monthly
RUN pacman-key --populate

MAINTAINER nemanjan00 nemanjan00@gmail.com

RUN pacman -Syu --noconfirm squid

EXPOSE 3128

CMD ["/usr/bin/squid", "-sYC"]

