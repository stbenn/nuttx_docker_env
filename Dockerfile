FROM ubuntu:24.04
LABEL Description="Nuttx Development Environment"


RUN apt-get update && apt-get -y --no-install-recommends install \
  build-essential \
  git