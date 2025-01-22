FROM ubuntu:24.04
LABEL Description="Nuttx Development Environment"

RUN apt-get update && apt-get -y install \
build-essential \
git \
sudo \
vim \
bison \
flex \
gettext \
texinfo \
libncurses5-dev \
libncursesw5-dev \
xxd \
gperf \
automake \
libtool \
pkg-config \
genromfs \
libgmp-dev \
libmpc-dev \
libmpfr-dev \
libisl-dev \
binutils-dev \
libelf-dev \
libexpat1-dev \
gcc-multilib \
g++-multilib \
picocom \
u-boot-tools \
util-linux \
kconfig-frontends \
gcc-arm-none-eabi \
binutils-arm-none-eabi \
gdb-multiarch

# Need this to allow SerialMonitor VSCode extension to work inside the container
RUN apt-get -y install udev

# Need OpenOCD for debugging!
RUN apt-get -y install openocd