#!/bin/bash

cd nuttx || { echo "Error: Could not navigate to nuttx subdirectory"; exit 1; }
make distclean -j
./tools/configure.sh -l nucleo-g071rb:nsh
make -j
cd ..