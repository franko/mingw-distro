#!/bin/sh

./binutils.sh
./coreutils.sh
./make.sh
./mingw-w64+gcc.sh
./boost.sh
./gdb.sh

# Removed from original mingw-distro from STL
# ./freetype.sh
# ./glbinding.sh
# ./glm.sh
# ./grep.sh
# ./lame.sh
# ./libjpeg-turbo.sh
# ./libpng.sh
# ./optipng.sh
# ./pcre.sh
# ./pcre2.sh
# ./pngcheck.sh
# ./sdl+libogg+libvorbis+sdl_mixer+vorbis-tools.sh
# ./sed.sh
# ./zlib.sh
# ./zstd.sh
