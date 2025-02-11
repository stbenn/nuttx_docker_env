#!/bin/bash

cd nuttx || { echo "Error: Could not navigate to nuttx subdirectory"; exit 1; }
make distclean -j
./tools/configure.sh -l nucleo-g071rb:nsh
kconfig-tweak --enable CONFIG_DEBUG_SYMBOLS
kconfig-tweak --enable EXTERNAL_APPS_HELLO_APP
make olddefconfig
make -j
cd ..