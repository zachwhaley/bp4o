#!/usr/bin/env sh
set -eu

prefix="/usr/local"
if [ -n "${PREFIX:-}" ]; then
    prefix=${PREFIX:-}
fi
mkdir -p $prefix/bin $prefix/share

rm -rf $prefix/bin/p4-*
for b in bin/p4-*; do
    install -v $b "$prefix/$b"
done
rm -rf $prefix/share/bp4o.sh
install -v -m 0444 bp4o.sh "$prefix/share/bp4o.sh"

echo "
BP4O Installed!
Now add the following to your shell's rc file to setup BP4O on login

[ -f $prefix/share/bp4o.sh ] && source $prefix/share/bp4o.sh
"
