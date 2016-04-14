#!/usr/bin/env sh
set -e

prefix="/usr/local"
[ -n "$1" ] && prefix="$1"
share="/usr/local/share/bp4o"
[ $(whoami) != "root" ] && share="${XDG_DATA_HOME:=$HOME/.local/share}/bp4o"

rm -rf $prefix/bin/p4-*
rm -rf $share/init.*

mkdir -p $prefix/bin $share
for b in bin/p4-*; do
    install -v $b "$prefix/$b"
done
for i in init.*; do
    install -v -m 0444 $i "$share/$i"
done

init="${share/#$HOME/'~'}/init.${SHELL##*/}"
echo "
BP4O Installed!
Now add the following to your shell's rc file to setup BP4O on login

[ -f $init ] && source $init
"
