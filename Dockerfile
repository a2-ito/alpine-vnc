# see hooks/build and hooks/.config
ARG BASE_IMAGE_PREFIX
FROM ${BASE_IMAGE_PREFIX}alpine:3.10

# see hooks/post_checkout
ARG ARCH
COPY qemu-${ARCH}-static /usr/bin

# add repository
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# install VNC & the desktop system
RUN uname -ar > /uname.build
RUN apk --update add file

# install VNC & the desktop system
RUN \
  apk --update --no-cache add x11vnc shadow xvfb \
        exo xfce4-whiskermenu-plugin gtk-xfce-engine thunar numix-themes-xfwm4 \
        xfce4-panel xfce4-session xfce4-settings xfce4-terminal xfconf xfdesktop xfwm4 xsetroot \
        ttf-dejavu numix-themes-gtk2 adwaita-icon-theme \
        unrar firefox-esr
