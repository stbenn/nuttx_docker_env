FROM ubuntu:24.04
LABEL Description="Nuttx Development Environment"


RUN apt-get update && apt-get -y --no-install-recommends install \
build-essential git \
bison flex gettext texinfo libncurses5-dev xxd \
gperf automake libtool pkg-config genromfs \
libgmp-dev libmpc-dev libmpfr-dev libisl-dev binutils-dev libelf-dev \
libexpat1-dev gcc-multilib g++-multilib picocom u-boot-tools util-linux \
kconfig-frontends gcc-arm-none-eabi binutils-arm-none-eabi