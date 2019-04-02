#!/bin/sh

source ./0_append_distro_path.sh

download_archive http://ftp.gnu.org/gnu/make/make-4.2.1.tar.gz
untar_file make-4.2.1.tar

cd "$X_BUILD_DIR"
mkdir -p dest/bin

mv make-4.2.1 src
cd src
cmd /c "build_w32.bat gcc"
strip -s GccRel/gnumake.exe
mv GccRel/gnumake.exe ../dest/bin/make.exe
# mingw32-make.exe is for CMake.
cp ../dest/bin/make.exe ../dest/bin/mingw32-make.exe
cd "$X_BUILD_DIR"
rm -rf src

mv dest make-4.2.1
cd make-4.2.1

7z -mx0 a ../make-4.2.1.7z *
