#!/usr/bin/env bash
set -e

if [ "$1" == "-nope" ]; then
    nope=1
    shift
fi
prefix="/usr/local"
[ -n "$1" ] && prefix="$1"
share="$prefix/share/bp4o"
[ $(whoami) != "root" ] && share="${XDG_DATA_HOME:=$HOME/.local/share}/bp4o"

rm -vf $prefix/bin/p4-*
rm -vf $share/init.*
if [ -n "$nope" ]; then
    echo "BP4O Uninstalled!"
    exit
fi

mkdir -p $prefix/bin $share
for b in bin/p4-*; do
    install -v $b "$prefix/$b"
done
for i in init.*; do
    install -v -m 0444 $i "$share/$i"
done

# Bash 4 expands ~ to the home directory, but Bash 3 doesn't.
# Unfortunately Bash 3 prints '~' literally, while Bash 4 prints only ~
if [ ${BASH_VERSION%%\.[1-9]*} -ge 4 ]; then
    share="${share/#$HOME/'~'}"
else
    share="${share/#$HOME/~}"
fi
init="$share/init.${SHELL##*/}"
echo "
BP4O Installed!
Now add the following to your shell's rc file to setup BP4O on login

[ -f $init ] && source $init
"
