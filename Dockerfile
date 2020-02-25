FROM ubuntu:18.04


# install git and other deps
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime
RUN apt-get -qq update && apt-get -qq install git wget libssl-dev build-essential software-properties-common rsync openssh-client
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils




