FROM ubuntu:18.10

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y && apt clean
RUN apt install -y git curl xz-utils && apt clean

WORKDIR /root

RUN curl https://download.qemu.org/qemu-3.1.0.tar.xz | tar -xJ
RUN curl https://busybox.net/downloads/busybox-1.29.2.tar.bz2 | tar -xj

RUN git clone --depth=1 https://github.com/riscv/riscv-gnu-toolchain
RUN cd riscv-gnu-toolchain && git submodule update --init --recursive --depth=1 riscv-binutils
RUN cd riscv-gnu-toolchain && git submodule update --init --recursive --depth=1 riscv-gcc
RUN cd riscv-gnu-toolchain && git submodule update --init --recursive --depth=1 riscv-gdb
RUN cd riscv-gnu-toolchain && git submodule update --init --recursive --depth=1000 riscv-glibc
RUN cd riscv-gnu-toolchain && git submodule update --init --recursive --depth=1000 riscv-newlib
RUN cd riscv-gnu-toolchain && git submodule update --init --recursive riscv-qemu
RUN git clone https://github.com/torvalds/linux.git && cd linux && git checkout v4.20
RUN git clone --depth=1 https://github.com/riscv/riscv-fesvr.git
RUN git clone --depth=1 https://github.com/riscv/riscv-isa-sim.git
RUN git clone --depth=1 https://github.com/riscv/riscv-pk.git

ENV RISCV=/usr/local
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
