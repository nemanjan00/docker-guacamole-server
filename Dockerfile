FROM base/devel:latest

MAINTAINER nemanjan00 nemanjan00@gmail.com

RUN pacman -Syu
RUN pacman -S squid

EXPOSE 3128

CMD ["/usr/bin/squid", "-sYC"]

