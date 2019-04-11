#!/bin/sh

source ./0_append_distro_path.sh

get_archive boost

cd "$X_BUILD_DIR"
mv boost src
mkdir -p dest/include
cd src

./bootstrap.sh

./b2 $X_B2_JOBS address-model=64 link=static runtime-link=static threading=multi variant=release \
--stagedir="$X_BUILD_DIR/dest" stage

cd "$X_BUILD_DIR/dest/lib"
for i in *.a; do mv $i ${i%-mgw*.a}.a; done
cd "$X_BUILD_DIR"
mv src/boost dest/include
rm -rf src

mv dest boost
cd boost

tar czf "../$(package_version_name boost).tar.gz" *
