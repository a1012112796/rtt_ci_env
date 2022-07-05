FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# install scons and other base tools by apt
RUN apt-get update \
    && apt-get upgrade -y -qq \
    && apt-get -qq -y install git curl gcc-multilib libsdl-dev libncurses5-dev python3 python-is-python3 python3-pip scons \
    && python --version \
    && python -m pip install --upgrade pip -qq \
# clean apt cache
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apk/* \
# Install Mips ToolChains
    && curl -SL https://github.com/RT-Thread/toolchains-ci/releases/download/v1.1/mips-2016.05-7-mips-sde-elf-i686-pc-linux-gnu.tar.bz2 \
    | tar -jx -C /opt \
    && /opt/mips-2016.05/bin/mips-sde-elf-gcc --version

ENV RTT_EXEC_PATH=/opt/mips-2016.05/bin
ENV RTT_CC='gcc'
