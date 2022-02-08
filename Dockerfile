#FROM ${BASE_IMAGE_PREFIX}php:apache-buste1
# see hooks/build and hooks/.config
ARG BASE_IMAGE_PREFIX
FROM ${BASE_IMAGE_PREFIX}alpine:3.15

# see hooks/post_checkout
#ARG ARCH
#COPY qemu-${ARCH}-static /usr/bin

# add repository
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# install VNC & the desktop system
RUN uname -ar > /uname.build
RUN apk --update add file

# install VNC & the desktop system
RUN \
  apk --update --no-cache add x11vnc shadow xvfb \
        exo xfce4-whiskermenu-plugin thunar numix-themes-xfwm4 \
        xfce4-panel xfce4-session xfce4-settings xfce4-terminal xfconf xfdesktop xfwm4 xsetroot \
        ttf-dejavu numix-themes-gtk2 adwaita-icon-theme \
        firefox-esr

RUN \
  apk --update --no-cache add supervisor sudo && \
  addgroup alpine && \
  adduser -G alpine -s /bin/sh -D alpine && \
  echo "alpine:alpine" | /usr/sbin/chpasswd && \
  echo "alpine    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install Japanese environment
RUN \
  apk --no-cache add ibus-anthy

# add repository
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# Install Japanese environment
RUN \
  apk --no-cache add font-ipa

# clean-up
RUN \
  apk del tzdata && \
  rm -Rf /apk /tmp/* /var/cache/apk/*

ADD etc /etc
WORKDIR /home/alpine
EXPOSE 5900
USER alpine

RUN echo 'export GTK_IM_MODULE=ibus' >> ~/.bashrc
RUN echo 'export XMODIFIERS=@im=ibus' >> ~/.bashrc
RUN echo 'export QT_IM_MODULE=ibus' >> ~/.bashrc

CMD ["sudo","/usr/bin/supervisord","-c","/etc/supervisord.conf"]
