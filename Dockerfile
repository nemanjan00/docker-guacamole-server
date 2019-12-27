FROM archlinux/base
MAINTAINER nemanjan00 nemanjan00@gmail.com

RUN pacman -Syu --noconfirm git base-devel

RUN pacman -S --needed --noconfirm sudo

RUN pacman -S --noconfirm pango libvorbis libwebp libpulse libvorbis openssl-1.0 libssh libvncserver ffmpeg

RUN useradd builduser -m # Create the builduser
RUN passwd -d builduser # Delete the buildusers password
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers

# libtelnet
RUN sudo -u builduser bash -c 'cd ~ && git clone https://aur.archlinux.org/libtelnet.git target && cd target && makepkg -si --noconfirm && sudo pacman --noconfirm -U *.pkg.* && cd .. && rm -rf target'

# uuid
RUN sudo -u builduser bash -c 'cd ~ && git clone https://aur.archlinux.org/uuid.git target && cd target && makepkg -si --noconfirm && sudo pacman --noconfirm -U *.pkg.* && cd .. && rm -rf target'

# guacamole
RUN sudo -u builduser bash -c 'cd ~ && git clone https://aur.archlinux.org/guacamole-server.git guacamole-server && cd guacamole-server && makepkg -si --noconfirm && sudo pacman --noconfirm -U guacamole-server-*.pkg.* && cd .. && rm -rf guacamole-server'

