# alpine-vnc

This is a Dockerfile for VNC Server on alpine Linux.
This Dockerfile for ARM architecture, especially Raspberry Pi, can be built on your x86 environtment including VM on Vagrant by using ```qemu-user-static```.

https://github.com/multiarch/qemu-user-static

In terms of the version of ARM arhcitecture related to the version of the base image, which is alpine Linux,
the raspberry Pi 3 may have 64-bit CPU, bur for now its default Linux OS remains at 32 bits. Therefore, it should be 
ARM 32bit architecture.

## Environment
```
Red Hat Enterprise Linux Server release 7.6 (Maipo)
VirtualBox 6.0

```
 
## Docker Build for x86 container
```
docker build -t alpine-vnc
```

## Docker Build for ARM container on x86 environment
### Prerequisites
```
$ uname -m
x86_64

$ docker run --rm -t arm64v8/ubuntu uname -m
standard_init_linux.go:211: exec user process caused "exec format error"

$ docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

$ docker run --rm -t arm64v8/ubuntu uname -m
aarch64

docker run --rm --privileged multiarch/qemu-user-static:register
```

### Build Conatainer
```
docker build . -t alpine-vnc:arm32v7
```

## Docker run 
```
docker run -d -p 5900:5900 --privileged --name alpine-vnc alpine-vnc
```

