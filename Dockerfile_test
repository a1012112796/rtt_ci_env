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
# Install Arm ToolChains
    && curl -SL https://github.com/RT-Thread/toolchains-ci/releases/download/v1.3/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 \
    | tar -xj -C /opt \
    && /opt/gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-gcc --version \
# Install AArch64 ToolChains
    && curl -SL https://github.com/RT-Thread/toolchains-ci/releases/download/v1.6/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf.tar.xz \
    | tar -x -C /opt \
    && /opt/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf/bin/aarch64-none-elf-gcc --version \
# Install Mips ToolChains
    && curl -SL https://github.com/RT-Thread/toolchains-ci/releases/download/v1.1/mips-2016.05-7-mips-sde-elf-i686-pc-linux-gnu.tar.bz2 \
    | tar -xj -C /opt \
    && /opt/mips-2016.05/bin/mips-sde-elf-gcc --version \
# Install Riscv64-unknown-elf ToolChains
    && curl -SL https://github.com/RT-Thread/toolchains-ci/releases/download/v1.4/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz \
    | tar -xz -C /opt \
    && /opt/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin/riscv64-unknown-elf-gcc --version \
# Install Riscv-none-embed ToolChains
    && curl -SL https://github.com/RT-Thread/toolchains-ci/releases/download/v1.5/xpack-riscv-none-embed-gcc-8.3.0-2.3-linux-x64.tar.gz \
    | tar -xz -C /opt \
    && /opt/xpack-riscv-none-embed-gcc-8.3.0-2.3/bin/riscv-none-embed-gcc --version
ENV RTT_EXEC_PATH=/opt/gcc-arm-none-eabi-6-2017-q2-update/bin
ENV RTT_CC='gcc'