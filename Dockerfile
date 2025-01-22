FROM ubuntu:24.04
LABEL Description="Nuttx Development Environment"

ARG USER_GID
ENV USER_GID=${USER_GID:-1000}
ARG USER_UID
ENV USER_UID=${USER_UID:-1000}
ARG USER_NAME
ENV USER_NAME=${USER_NAME:-developer}

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

# Create the user with build args passed
RUN groupadd -o --gid $USER_GID $USER_NAME \
    && useradd -o --uid $USER_UID --gid $USER_GID -m $USER_NAME \
    && echo $USER_NAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_NAME \
    && chmod 0440 /etc/sudoers.d/$USER_NAME

USER $USER_NAME