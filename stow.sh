#!/usr/bin/env bash

# Script expects to be run from dotfiles root directory
# (the directory where this script is located)
# This check ensures we're in the correct location
if [[ ! -f ./.dotfiles ]]; then
    echo 'ERROR: must be run from dotfiles root directory' >&2
    exit 1
fi

help="Usage:
    ${0#*/} [-n] <package> ...
    ${0#*/} [options]

Options:
    -n               Simulate stowing (dry run)
    --show           Show available packages
    --show-all       Show all packages including hidden ones
    --show-hidden    Show only hidden packages
    -h, --help       Show help message"

set -e

function list_packages() {
    for path in */*/; do
        path=${path%/}

        # Skip `misc` folder
        [[ $path == misc/* ]] && continue

        # Skip hidden package if in regular mode
        [[ $1 == --show && -f $path/.nostow ]] && continue

        # Skip regular package if in hidden-only mode
        [[ $1 == --show-hidden && ! -f $path/.nostow ]] && continue

        echo "$path"
    done
}

case $1 in
-n)
    simulate=$1
    shift
    ;;
--show | --show-all | --show-hidden)
    list_packages $1
    exit 0
    ;;
-h | --help)
    echo "$help"
    exit 0
    ;;
esac

# Check if there are packages to process
if (($# == 0)); then
    echo "$help" >&2
    exit 1
fi

if ! command -v stow >/dev/null 2>&1; then
    echo 'ERROR: GNU Stow is required but not installed' >&2
    exit 1
fi

for path in "$@"; do
    if [[ ! $path =~ ^[^/]+/[^/]+$ ]]; then
        echo "WARNING: '$path' must be in the format 'module/package', skipping..."
        continue
    fi
    if [[ ! -d $path ]]; then
        echo "WARNING: package '$path' does not exist, skipping..."
        continue
    fi
    if [[ $path == misc/* || -f $path/.nostow ]]; then
        echo "INFO: package '$path' is hidden, skipping..."
        continue
    fi

    IFS=/ read -r module package <<<"$path"
    base=${XDG_CONFIG_HOME:-$HOME/.config}/$package

    if [[ -d $path/home ]]; then
        echo "INFO: stowing $path into HOME=$HOME"
        stow --ignore='\.DS_Store' -t "$HOME" -d "$path" -Rv $simulate home
    fi

    # Check if there is anything else to stow
    files=("$path"/!(home))
    if [[ -e ${files[0]} ]]; then
        echo "INFO: stowing $path into $base"
        mkdir -p "$base"
        stow --ignore='\.DS_Store|home' -t "$base" -d "$module" -Rv $simulate "$package"
    fi
done
