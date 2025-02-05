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
libelf-dev \
libexpat1-dev \
picocom \
u-boot-tools \
util-linux \
kconfig-frontends \
binutils-dev

# For version specific toolchains, important for building binarys. 
RUN apt-get -y install \
gcc-arm-none-eabi=15:13.2.rel1-2 \
binutils-arm-none-eabi=2.42-1ubuntu1+23 \
gdb-multiarch=15.0.50.20240403-0ubuntu1 \
gcc-multilib=4:13.2.0-7ubuntu1 \
g++-multilib=4:13.2.0-7ubuntu1

# Need this to allow SerialMonitor VSCode extension to work inside the container
RUN apt-get -y install udev

# Need OpenOCD for debugging!
RUN apt-get -y install openocd

RUN rm -rf /var/lib/apt/lists/*