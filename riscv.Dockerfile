FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# install scons and other base tools by apt
RUN apt-get update \
    && apt-get upgrade -y -qq \
    && apt-get -qq -y install git curl gcc-multilib libsdl-dev libncurses5-dev python3 python-is-python3 python3-pip scons \
    && python --version \
    && python -m pip install --upgrade pip -qq \
    && pip install requests -qq \
# clean apt cache
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apk/* \
# Install Riscv-none-embed ToolChains
    && curl -SL https://github.com/RT-Thread/toolchains-ci/releases/download/v1.5/xpack-riscv-none-embed-gcc-8.3.0-2.3-linux-x64.tar.gz \
    | tar -xz -C /opt \
    && /opt/xpack-riscv-none-embed-gcc-8.3.0-2.3/bin/riscv-none-embed-gcc --version

ENV RTT_EXEC_PATH=/opt/xpack-riscv-none-embed-gcc-8.3.0-2.3/bin
ENV RTT_CC='gcc'
