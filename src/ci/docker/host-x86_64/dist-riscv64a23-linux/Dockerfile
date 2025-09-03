FROM public-docker-virtual.artnj.zte.com.cn/ubuntu:24.04 

RUN sed -i 's|http://archive.ubuntu.com|http://mirrors.zte.com.cn|g' /etc/apt/sources.list.d/ubuntu.sources && \
    sed -i 's|http://security.ubuntu.com|http://mirrors.zte.com.cn|g' /etc/apt/sources.list.d/ubuntu.sources

COPY scripts/cross-apt-packages.sh /scripts/
RUN sh /scripts/cross-apt-packages.sh

COPY scripts/crosstool-ng.sh /scripts/
RUN sh /scripts/crosstool-ng.sh

COPY scripts/rustbuild-setup.sh /scripts/
RUN sh /scripts/rustbuild-setup.sh
WORKDIR /tmp

COPY scripts/crosstool-ng-build.sh /scripts/
COPY host-x86_64/dist-riscv64a23-linux/patches/ /tmp/patches/
COPY host-x86_64/dist-riscv64a23-linux/riscv64-unknown-linux-gnu.defconfig /tmp/crosstool.defconfig
RUN /scripts/crosstool-ng-build.sh

COPY scripts/sccache.sh /scripts/
RUN sh /scripts/sccache.sh

ENV PATH=$PATH:/x-tools/riscv64-unknown-linux-gnu/bin

COPY host-x86_64/dist-riscv64a23-linux/build-openssl-riscv64.sh /scripts/
RUN sh /scripts/build-openssl-riscv64.sh

ENV RISCV64A23_UNKNOWN_LINUX_GNU_OPENSSL_NO_VENDOR=1 \
    RISCV64A23_UNKNOWN_LINUX_GNU_OPENSSL_DIR=/opt/openssl/riscv64a23-unknown-linux-gnu  \
    RISCV64A23_UNKNOWN_LINUX_GNU_OPENSSL_LIB_DIR=/opt/openssl/riscv64a23-unknown-linux-gnu/lib \
    RISCV64A23_UNKNOWN_LINUX_GNU_OPENSSL_INCLUDE_DIR=/opt/openssl/riscv64a23-unknown-linux-gnu/include \
    RISCV64A23_UNKNOWN_LINUX_GNU_OPENSSL_STATIC=1 \
    OPENSSL_NO_VENDOR=1 \
    OPENSSL_DIR=/opt/openssl/riscv64a23-unknown-linux-gnu \
    OPENSSL_LIB_DIR=/opt/openssl/riscv64a23-unknown-linux-gnu/lib \
    OPENSSL_INCLUDE_DIR=/opt/openssl/riscv64a23-unknown-linux-gnu/include \
    OPENSSL_STATIC=1

ENV CC_riscv64a23_unknown_linux_gnu=riscv64-unknown-linux-gnu-gcc \
    AR_riscv64a23_unknown_linux_gnu=riscv64-unknown-linux-gnu-ar \
    CXX_riscv64a23_unknown_linux_gnu=riscv64-unknown-linux-gnu-g++

ENV HOSTS=riscv64a23-unknown-linux-gnu

ENV RUST_CONFIGURE_ARGS --enable-extended --enable-profiler --disable-docs
ENV SCRIPT python3 ../x.py dist --target $HOSTS --host $HOSTS
