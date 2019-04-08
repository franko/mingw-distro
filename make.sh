#!/bin/sh

source ./0_append_distro_path.sh

get_archive make

cd "$X_BUILD_DIR"
mkdir -p dest/bin

mv make src
cd src
cmd /c "build_w32.bat gcc"
strip -s GccRel/gnumake.exe
mv GccRel/gnumake.exe ../dest/bin/make.exe
# mingw32-make.exe is for CMake.
cp ../dest/bin/make.exe ../dest/bin/mingw32-make.exe
cd "$X_BUILD_DIR"
rm -rf src

mv dest make
cd make

tar czf "../$(package_version_name make).tar.gz" *
