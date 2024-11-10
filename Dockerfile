FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    g++ \
    cmake \
    libclang-dev\
    llvm-dev \
    python3 \
    python3-dev \
    python3-pip \
    libsqlite3-dev \
    libxml2-dev \
    libgtk-3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN wget https://www.nsnam.org/releases/ns-allinone-3.43.tar.bz2 && \
    tar xjf ns-allinone-3.43.tar.bz2 && \
    rm ns-allinone-3.43.tar.bz2

WORKDIR /opt/ns-allinone-3.43/ns-3.43

RUN ./ns3 configure --enable-examples --enable-tests
# Download cppyy to enable python bindings
RUN python3 -m pip install cppyy==3.1.2 --break-system-packages
RUN ./ns3 configure --enable-python-bindings
RUN ./ns3 build
CMD ["/bin/bash"]