#!/bin/sh

# Reject expansion of unset variables.
set -u

# Exit when a command fails.
if [ "${PS1:-}" == "" ]; then set -e; fi

source ./0_sources.sh

X_DOWNLOADS_DIR=/c/temp/mingw-build/downloads
X_BUILD_DIR=/c/temp/mingw-build/sources

mkdir -p "$X_DOWNLOADS_DIR"
mkdir -p "$X_BUILD_DIR"

function archive_uncompress {
    local archive_ext="${1##*.}"
    case $archive_ext in
    gz)
        gunzip "$1"
        ;;
    xz)
        unxz "$1"
        ;;
    lz)
        lzip -d "$1"
        ;;
    bz2)
        bunzip2 "$1"
        ;;
    *)
        echo "unknown compression format $archive_ext"
        exit 1
    esac
}

function get_archive {
    local archive_url="${X_SOURCES[$1]}"
    local archive_ext="${archive_url##*.}"
    local name="${archive_url##*/}"
    local sources_dir_name="${name%.tar.*}"

    # The -k option below is to ignore bad SSL certs.
    curl -k -L "$archive_url" -o "$X_DOWNLOADS_DIR/$name"
    pushd "$X_DOWNLOADS_DIR"
    archive_uncompress "$name"
    tar --extract --directory="$X_BUILD_DIR" --file="${name%.*}"
    popd

    if [ ${X_SOURCES_PATCH[$1]+x} ]; then
        echo "Applying patch: ${X_SOURCES_PATCH[$1]}"
        patch -d "$X_BUILD_DIR/$sources_dir_name" -p1 < "${X_SOURCES_PATCH[$1]}"
    fi

    # set the package's directory name
    X_SOURCES_DIR[$1]="$sources_dir_name"
}

export X_MAKE_JOBS="-j$NUMBER_OF_PROCESSORS -O"
export X_B2_JOBS="-j$NUMBER_OF_PROCESSORS"

# Print commands.
if [ "${PS1:-}" == "" ]; then set -x; fi
