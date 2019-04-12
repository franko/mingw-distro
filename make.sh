#!/bin/sh

source ./0_append_distro_path.sh

pkg_name=make
pkg_version=4.2.1
pkg_source_dir=make
pkg_source_url="http://ftp.gnu.org/gnu/make/make-${pkg_version}.tar.gz"

get_archive "$pkg_source_dir" "$pkg_source_url"

cd "$X_BUILD_DIR"
mkdir -p dest/bin

mv "$pkg_source_dir" src
cd src
cmd /c "build_w32.bat gcc"
strip -s GccRel/gnumake.exe
mv GccRel/gnumake.exe ../dest/bin/make.exe
# mingw32-make.exe is for CMake.
cp ../dest/bin/make.exe ../dest/bin/mingw32-make.exe
cd "$X_BUILD_DIR"
rm -rf src

mv dest "$pkg_source_dir"
cd "$pkg_source_dir"

tar czf "../${pkg_name}-${pkg_version}.tar.gz" *
