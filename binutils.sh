#!/bin/sh

source ./0_append_distro_path.sh

get_archive binutils

BINUTILS_DIR="${X_SOURCES_DIR[binutils]}"

cd "$X_BUILD_DIR"
mv "$BINUTILS_DIR" src
mkdir build dest
cd build

../src/configure --disable-nls --disable-shared --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 \
--target=x86_64-w64-mingw32 --disable-multilib --prefix="$X_BUILD_DIR/dest" --with-sysroot="$X_BUILD_DIR/dest"

make $X_MAKE_JOBS all "CFLAGS=-O3" "LDFLAGS=-s"
make $X_MAKE_JOBS install
cd "$X_BUILD_DIR"
rm -rf build src
mv dest "$BINUTILS_DIR"
cd "$BINUTILS_DIR"
rm -rf lib/*.la share

7z -mx0 a "../$BINUTILS_DIR.7z" *
