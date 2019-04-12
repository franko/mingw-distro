#!/bin/sh

source ./0_append_distro_path.sh

get_archive gdb

cd "$X_BUILD_DIR"
mv gdb src
mkdir build dest
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix="$X_BUILD_DIR/dest" --disable-nls

make $X_MAKE_JOBS all "CFLAGS=-O3" "LDFLAGS=-s"
make $X_MAKE_JOBS install
cd "$X_BUILD_DIR"
rm -rf build src
mv dest gdb
cd gdb
rm -rf bin/gdb-add-index include lib share

tar czf "../$(package_version_name gdb).tar.gz" *
