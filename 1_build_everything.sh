#!/bin/sh

source ./0_append_distro_path.sh

./binutils.sh
./boost.sh
./coreutils.sh
echo SKIPPING
cat << EOF
./freetype.sh
./gdb.sh
./glbinding.sh
./glm.sh
./grep.sh
./lame.sh
./libjpeg-turbo.sh
./libpng.sh
EOF
./make.sh
./mingw-w64+gcc.sh
exit 1
./optipng.sh
./pcre.sh
./pcre2.sh
./pngcheck.sh
./sdl+libogg+libvorbis+sdl_mixer+vorbis-tools.sh
./sed.sh
./zlib.sh
./zstd.sh
