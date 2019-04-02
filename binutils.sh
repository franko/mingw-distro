#!/bin/sh

source ./0_append_distro_path.sh

download_archive http://ftp.gnu.org/gnu/binutils/binutils-2.31.1.tar.gz
untar_file binutils-2.31.1.tar

cd "$X_BUILD_DIR"
mv binutils-2.31.1 src
mkdir build dest
cd build

../src/configure --disable-nls --disable-shared --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 \
--target=x86_64-w64-mingw32 --disable-multilib --prefix="$X_BUILD_DIR/dest" --with-sysroot="$X_BUILD_DIR/dest"

make $X_MAKE_JOBS all "CFLAGS=-O3" "LDFLAGS=-s"
make $X_MAKE_JOBS install
cd "$X_BUILD_DIR"
rm -rf build src
mv dest binutils-2.31.1
cd binutils-2.31.1
rm -rf lib/*.la share

7z -mx0 a ../binutils-2.31.1.7z *
