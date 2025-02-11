# Nuttx Docker Environment
This project provides an example NuttX development workspace and setup for external apps. 
It is utilizing Docker for environment containerization and GNU make + bash scripts to automate project setup.

## Getting Started

### Pre-requirements
For a Windows host machine (running WSL2):
1. WSL2 instance running an Ubuntu distro (Tested with 24.04. Other distros/versions may work but have not been tested).
1. Docker desktop installed on host machine, with WSL integration enabled for the desired distro (Docker settings > Resources > WSL integration)
1. VSCode with C/C++, Dev Containers, and Cortex-Debug extensions. This project has preconfigured launch and build command settings for VSCode included in the `.vscode` directory.
    - Any editor with support for connecting to containers should work, but you will have to find alternatives for the Cortex-Debug extension.
    - **NOTE:** C/C++ Extension v1.23.5 does not follow symlinks properly. Previous and following versions work.
1. If using a USB debugger such as the STLink included on Nucleo dev boards, make sure to share and attach the USB to the WSL instance. This is necessary to access the debugger from within WSL and by extension Docker.
    - Instructions can be accessed here:  https://learn.microsoft.com/en-us/windows/wsl/connect-usb (Search "Connect USB device to WSL" if this link is broken)

### Repo/project Setup
1. Clone this repository inside WSL2.
1. In the repo base directory, run `make init` to run first time setup:
    - Builds docker image from Dockerfile, tagging it as `nuttx_env/project_name:image_version`
    - Initialize the nuttx and apps (nuttx-apps) submodules
    - Links external application into `apps/external`
    - Adds executable permissions to necessary scripts.
1. `make launch` will run the docker container. Attach to the running container with VSCode using the Remote Explorer. 
    - **NOTE:** If using a USB debugger, make sure to attach to WSL prior to launching the container.
