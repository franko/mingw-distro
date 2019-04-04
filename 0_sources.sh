declare -x -A X_SOURCES X_SOURCES_DIR X_SOURCES_PATCH

X_SOURCES[binutils]="http://ftp.gnu.org/gnu/binutils/binutils-2.31.1.tar.gz"
X_SOURCES[coreutils]="http://ftp.gnu.org/gnu/coreutils/coreutils-8.30.tar.xz"
X_SOURCES_PATCH[coreutils]="coreutils.patch"

X_SOURCES[make]="http://ftp.gnu.org/gnu/make/make-4.2.1.tar.gz"
X_SOURCES[gmp]="http://gmplib.org/download/gmp/gmp-6.1.2.tar.lz"

X_SOURCES[mpfr]="https://ftp.gnu.org/gnu/mpfr/mpfr-4.0.1.tar.gz"
X_SOURCES_PATCH[mpfr]="mpfr-4.0.1-p13.patch"

X_SOURCES[mpc]="https://ftp.gnu.org/gnu/mpc/mpc-1.1.0.tar.gz"
X_SOURCES[isl]="http://isl.gforge.inria.fr/isl-0.20.tar.gz"
X_SOURCES[mingw-w64]="https://downloads.sourceforge.net/project/mingw-w64/mingw-w64/mingw-w64-release/mingw-w64-v6.0.0.tar.bz2"

X_SOURCES[gcc]="https://ftp.gnu.org/gnu/gcc/gcc-8.2.0/gcc-8.2.0.tar.gz"
# Fixed upstream: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86724
X_SOURCES_PATCH[gcc]="gcc-bug-86724.patch"
