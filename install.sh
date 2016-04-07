#!/usr/bin/env sh
set -e

prefix="/usr/local"
[ -n $1 ] && prefix=$1

rm -rf $prefix/bin/p4-*
rm -rf $prefix/share/bp4o.sh

mkdir -p $prefix/bin $prefix/share
for b in bin/p4-*; do
    install -v $b "$prefix/$b"
done
install -v -m 0444 bp4o.sh "$prefix/share/bp4o.sh"

echo "
BP4O Installed!
Now add the following to your shell's rc file to setup BP4O on login

[ -f $prefix/share/bp4o.sh ] && source $prefix/share/bp4o.sh
"
