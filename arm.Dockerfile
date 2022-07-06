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
# Install Arm ToolChains
    && curl -SL https://github.com/RT-Thread/toolchains-ci/releases/download/v1.3/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 \
    | tar -xj -C /opt \
    && /opt/gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-gcc --version

ENV RTT_EXEC_PATH=/opt/gcc-arm-none-eabi-10-2020-q4-major/bin
ENV RTT_CC='gcc'

CMD ["/bin/bash"]
