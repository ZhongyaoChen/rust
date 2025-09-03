OPENSSL_VER=openssl-3.0.14
PREFIX=/opt/openssl/riscv64a23-unknown-linux-gnu

export CC=riscv64-unknown-linux-gnu-gcc
export AR=riscv64-unknown-linux-gnu-ar
export RANLIB=riscv64-unknown-linux-gnu-ranlib
export NM=riscv64-unknown-linux-gnu-nm

rm -rf /tmp/openssl-build
mkdir -p /tmp/openssl-build
cd /tmp/openssl-build
git clone --depth=1 -b ${OPENSSL_VER} https://github.com/openssl/openssl.git
cd openssl

./Configure linux64-riscv64 no-shared --prefix="${PREFIX}" --openssldir="${PREFIX}/ssl"

make -j"$(nproc)"
make install_sw
