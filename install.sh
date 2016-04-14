#!/usr/bin/env sh
set -e

prefix="/usr/local"
[ -n "$1" ] && prefix=$1
data="${XDG_DATA_HOME:=$HOME/.local/share}/bp4o"

rm -rf $prefix/bin/p4-*
rm -rf $data/init.bash

mkdir -p $prefix/bin $data
for b in bin/p4-*; do
    install -v $b "$prefix/$b"
done
install -v -m 0444 init.bash "$data/init.bash"

echo "
BP4O Installed!
Now add the following to your shell's rc file to setup BP4O on login

[ -f $data/init.bash ] && source $data/init.bash
"
