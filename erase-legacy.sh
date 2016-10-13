#!/usr/bin/env bash
set -e

prefix="/usr/local"
[ -n "$1" ] && prefix="$1"
share="$prefix/share/bp4o"
[ $(whoami) != "root" ] && share="${XDG_DATA_HOME:=$HOME/.local/share}/bp4o"

rm -vf $prefix/bin/p4-*
rm -vf $share/init.*
echo "
Legacy BP4O Uninstalled!
"
