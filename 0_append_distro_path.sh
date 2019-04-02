#!/bin/sh

# Reject expansion of unset variables.
set -u

# Exit when a command fails.
if [ "${PS1:-}" == "" ]; then set -e; fi

export X_DISTRO_ROOT=/c/mingw

export X_DISTRO_BIN=$X_DISTRO_ROOT/bin
export X_DISTRO_INC=$X_DISTRO_ROOT/include
export X_DISTRO_LIB=$X_DISTRO_ROOT/lib

export PATH=$PATH:$X_DISTRO_BIN

export C_INCLUDE_PATH=$X_DISTRO_INC
export CPLUS_INCLUDE_PATH=$X_DISTRO_INC

X_DOWNLOADS_DIR=/c/temp/mingw-build/downloads
X_BUILD_DIR=/c/temp/mingw-build/sources

mkdir -p "$X_DOWNLOADS_DIR"
mkdir -p "$X_BUILD_DIR"

function download_archive {
    local archive_ext="${1##*\.}"
    local name="${1##*/}"
    curl -L "$1" -o "$X_DOWNLOADS_DIR/$name"
    pushd "$X_DOWNLOADS_DIR"
    case $archive_ext in
    gz)
        gunzip "$name"
        ;;
    xz)
        unxz "$name"
        ;;
    *)
        echo "unknown compression format $archive_type"
	exit 1
    esac
    popd
}

function untar_file {
    tar --extract --directory="$X_BUILD_DIR" --file="$X_DOWNLOADS_DIR/$1"
}

export X_MAKE_JOBS="-j$NUMBER_OF_PROCESSORS -O"
export X_B2_JOBS="-j$NUMBER_OF_PROCESSORS"

# Print commands.
if [ "${PS1:-}" == "" ]; then set -x; fi
