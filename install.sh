#!/usr/bin/env bash
set -e

if [ "$1" == "-u" ]; then
    nope=1
    shift
fi

prefix="${1:-/usr/local}"
if [ $(whoami) == "root" ]; then
    initdir="/etc/profile.d"
else
    initdir="${XDG_DATA_HOME:-$HOME/.profile.d}"
fi

# Uninstall BP4O
if [ -n "$nope" ]; then
    rm -vf $prefix/bin/p4-*
    rm -vf $initdir/bp4o.*
    echo "
BP4O Uninstalled!"
    exit
fi

# Remove existing BP4O scripts
rm -f $prefix/bin/p4-*
rm -f $initdir/bp4o.*

# Install BP4O
mkdir -p $prefix/bin $initdir
for b in bin/p4-*; do
    install -v $b "$prefix/$b"
done
for i in bp4o.*; do
    install -v -m 0444 $i "$initdir/$i"
done

# Bash 4 expands ~ to the home directory, but Bash 3 doesn't.
# Unfortunately Bash 3 prints '~' literally, while Bash 4 prints only ~
if [ ${BASH_VERSION%%\.[1-9]*} -ge 4 ]; then
    initdir="${initdir/#$HOME/'~'}"
else
    initdir="${initdir/#$HOME/~}"
fi
echo "
BP4O Installed!"
if [ $(whoami) != "root" ]; then
    shell="$(basename $SHELL)"
    init="$initdir/bp4o.$shell"
    echo "Add the following to your .${shell}rc file to setup BP4O:

    [ -f $init ] && source $init
"
fi
