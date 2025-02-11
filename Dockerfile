################################################################
# First build stage: to download and unpack the arm toolchain.
################################################################
FROM ubuntu:24.04 AS arm-toolchain

RUN apt-get update -qq && apt-get install -y -qq \
curl \
patch \
xz-utils

# Get the arm-none-eabi toolchain directly from Arm. Along with gcc and linker,
# contains all libraries necessary for compile. It gets copied to the final 
# image in the final build stage. 
RUN mkdir -p arm-none-eabi && \
curl -s -L "https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz" \ 
| tar --strip-components 1 -xJ -C arm-none-eabi

################################################################
# Final image for development
################################################################
FROM ubuntu:24.04
LABEL maintainer="tbennett@2g-eng.com"

# After install, clean up the cache to reduce size of image. 
# As a result, from within the container, will need to use apt-get update before
# any packages can be installed. Shouldn't be an issue, as all necessary 
# packages should be installed here
RUN apt-get update && apt-get -y install \
sudo \
build-essential \
git \
vim \
bison \
flex \
texinfo \
libncurses-dev \
xxd \
gperf \
automake \
libtool \
pkg-config \
genromfs \
u-boot-tools \
util-linux \
kconfig-frontends \
usbutils \
gdb-multiarch=15.0.50.20240403-0ubuntu1 \
libusb-1.0-0-dev \
udev \
openocd \
&& rm -rf /var/lib/apt/lists/*

# This removes the password for sudo commands. The run command adds the user
# to the sudo group, but need to do this as well
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Grab the toolchain from the nuttx-toolchain-arm image and add to path.
COPY --from=arm-toolchain /arm-none-eabi/ /usr/bin/arm-none-eabi/
ENV PATH="/usr/bin/arm-none-eabi/bin:$PATH"

CMD [ "/bin/bash" ]