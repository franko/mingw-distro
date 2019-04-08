#!/bin/sh

source ./0_append_distro_path.sh

get_archive coreutils

cd "$X_BUILD_DIR"
mv coreutils src
mkdir -p build dest/bin

# Missing <sys/wait.h>.
echo "/* ignore */" > src/lib/savewd.c

# Missing <pwd.h> and <grp.h>.
echo "/* ignore */" > src/lib/idcache.c
echo "/* ignore */" > src/lib/userspec.c

cd build
echo "ac_cv_header_pthread_h=no" > config.site
export CONFIG_SITE="$X_BUILD_DIR/build/config.site"

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix="$X_BUILD_DIR/dest"

touch src/make-prime-list
make $X_MAKE_JOBS -k "CFLAGS=-O3" "LDFLAGS=-s" || true
cd src
mv sort.exe uniq.exe wc.exe ../../dest/bin
cd "$X_BUILD_DIR"
rm -rf build src
mv dest coreutils
cd coreutils

tar czf "../$(package_version_name coreutils).tar.gz" *
