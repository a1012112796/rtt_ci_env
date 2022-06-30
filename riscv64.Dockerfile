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
# Install Riscv64-unknown-elf ToolChains
    && curl -SL https://github.com/RT-Thread/toolchains-ci/releases/download/v1.4/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz \
    | tar -xz -C /opt \
    && /opt/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin/riscv64-unknown-elf-gcc --version

ENV RTT_EXEC_PATH=/opt/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin
ENV RTT_CC='gcc'
