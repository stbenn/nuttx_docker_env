# nuttx_docker_env
Experiment to set up nuttx app environment.


## Setup Steps Followed

1. In repo base directory, add nuttx and nuttx-apps as submodules:
    1. Nuttx command: `git submodule add git@github.com:apache/nuttx.git nuttx`
    1. Nuttx-apps command: `git submodule add git@github.com:apache/nuttx-apps.git apps`


## Docker Setup Notes
Install packages required by Nuttx (https://nuttx.apache.org/docs/latest/quickstart/install.html) at the beginning of the dockerfile.

Building the docker image using command `docker build -t nuttxtest:0.1 .` right now, builds without errors. 