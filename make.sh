#!/bin/sh

source ./0_append_distro_path.sh

get_archive make
MAKE_DIR="${X_SOURCES_DIR[make]}"

cd "$X_BUILD_DIR"
mkdir -p dest/bin

mv "$MAKE_DIR" src
cd src
cmd /c "build_w32.bat gcc"
strip -s GccRel/gnumake.exe
mv GccRel/gnumake.exe ../dest/bin/make.exe
# mingw32-make.exe is for CMake.
cp ../dest/bin/make.exe ../dest/bin/mingw32-make.exe
cd "$X_BUILD_DIR"
rm -rf src

mv dest "$MAKE_DIR"
cd "$MAKE_DIR"

7z -mx0 a "../$MAKE_DIR.7z" *
