FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# install scons and other base tools by apt
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list \
    && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse " >> /etc/apt/sources.list \
    && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse " >> /etc/apt/sources.list \
    && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse " >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get upgrade -y -qq \
    && apt-get -qq -y install git curl gcc-multilib libsdl-dev libncurses5-dev python3 python-is-python3 python3-pip scons \
    && python --version \
    && python -m pip install --upgrade pip -qq \
# clean apt cache
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apk/* \
# Install AArch64 ToolChains
    && curl -SL https://github.com/RT-Thread/toolchains-ci/releases/download/v1.6/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf.tar.xz \
    | tar -x -C /opt \
    && /opt/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf/bin/aarch64-none-elf-gcc --version

ENV RTT_EXEC_PATH=/opt/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf/bin
ENV RTT_CC='gcc'
