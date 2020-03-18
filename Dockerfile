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
