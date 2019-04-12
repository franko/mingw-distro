#!/bin/sh

source ./0_append_distro_path.sh

pkg_name=binutils
pkg_version=2.31.1
pkg_source_dir=binutils
pkg_source_url="http://ftp.gnu.org/gnu/binutils/binutils-${pkg_version}.tar.gz"

get_archive "$pkg_source_dir" "$pkg_source_url"

cd "$X_BUILD_DIR"
mv "$pkg_source_dir" src
mkdir build dest
cd build

../src/configure --disable-nls --disable-shared --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 \
--target=x86_64-w64-mingw32 --disable-multilib --prefix="$X_BUILD_DIR/dest" --with-sysroot="$X_BUILD_DIR/dest"

make $X_MAKE_JOBS all "CFLAGS=-O3" "LDFLAGS=-s"
make $X_MAKE_JOBS install
cd "$X_BUILD_DIR"
rm -rf build src
mv dest "pkg_source_dir"
cd "pkg_source_dir"
rm -rf lib/*.la share

tar czf "../${pkg_name}-${pkg_version}.tar.gz" *
