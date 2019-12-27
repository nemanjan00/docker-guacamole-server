FROM archlinux/base
MAINTAINER nemanjan00 nemanjan00@gmail.com

RUN pacman -Syu --noconfirm git base-devel

RUN pacman -S --needed --noconfirm sudo
RUN useradd builduser -m # Create the builduser
RUN passwd -d builduser # Delete the buildusers password
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers
RUN sudo -u builduser bash -c 'cd ~ && git clone https://aur.archlinux.org/guacamole-server.git guacamole-server && cd guacamole-server && makepkg -si --noconfirm && sudo pacman --noconfirm -U guacamole-server-*.pkg.* && cd .. && rm -rf guacamole-server'

