#!/usr/bin/env bash
set -e

if [ "$1" == "-u" ]; then
    nope=1
    shift
fi

prefix="${1:-/usr/local}"
if [ $(whoami) == "root" ]; then
    bashdir="/etc/profile.d"
    zshdir="/usr/share/zsh/site-functions"
else
    initdir="${XDG_DATA_HOME:-$HOME/.local/share/bp4o}"
fi

uninstall() {
    local opts=$1
    rm $opts $prefix/bin/p4-*
    rm $opts $initdir/bp4o.*
    if [ $(whoami) == "root" ]; then
        rm $opts $bashdir/bp4o.sh
        rm $opts $zshdir/bp4o
    fi
}

# Uninstall BP4O
if [ -n "$nope" ]; then
    uninstall -vf
    echo "
BP4O Uninstalled!"
    exit
fi

# Remove existing BP4O scripts
uninstall -f

# Install BP4O
mkdir -p $prefix/bin $initdir
for b in bin/p4-*; do
    install -v -p $b "$prefix/$b"
done
if [ $(whoami) == "root" ]; then
    mkdir -p $bashdir $zshdir
    install -v -p -m 444 bp4o.bash $bashdir/bp4o.sh
    install -v -p -m 444 bp4o.zsh $zshdir/bp4o
else
    mkdir -p $initdir
    for i in bp4o.*; do
        install -v -p -m 444 $i "$initdir/$i"
    done
fi

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
