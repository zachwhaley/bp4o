#!/usr/bin/env bash
set -e

if [ "$1" == "-u" ]; then
    nope=1
    shift
fi

if [ $(whoami) == "root" ]; then
    bashdir="/etc/profile.d"
    zshdir="/usr/share/zsh/site-functions"
    fishdir="/usr/share/fish/vendor_functions.d"
else
    bashdir="$HOME/.profile.d"
    zshdir="$HOME/.local/share/zsh/functions"
    fishdir="$HOME/.config/fish/functions"
fi
prefix="${1:-/usr/local}"

uninstall() {
    local opts=$1
    rm $opts $prefix/bin/p4-*
    rm $opts $bashdir/bp4o.sh
    rm $opts $zshdir/bp4o
    rm $opts $fishdir/p4.fish
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
mkdir -p $prefix/bin
for b in bin/p4-*; do
    install -v -p $b "$prefix/$b"
done
mkdir -p $bashdir $zshdir $fishdir
install -v -p -m 444 bp4o.bash $bashdir/bp4o.sh
install -v -p -m 444 bp4o.zsh $zshdir/bp4o
install -v -p -m 444 bp4o.fish $fishdir/p4.fish

echo "
BP4O Installed!"
shell="$(basename $SHELL)"
if [ $(whoami) == "root" ]; then
cat <<EOM

Zsh users, add the following to your ~/.zshrc:

    autoload -Uz bp4o
    bp4o

Bash users, you're ready to go!
Fish users, you're ready to go!

EOM
else
# Bash 4 expands ~ to the home directory, but Bash 3 doesn't.
# Unfortunately Bash 3 prints '~' literally, while Bash 4 prints only ~
if [ ${BASH_VERSION%%\.[1-9]*} -ge 4 ]; then
    bashdir="${bashdir/#$HOME/'~'}"
    zshdir="${zshdir/#$HOME/'~'}"
else
    bashdir="${bashdir/#$HOME/~}"
    zshdir="${zshdir/#$HOME/~}"
fi
cat <<EOM

Bash users, add the following to your ~/.bashrc:

    [ -f $bashdir/bp4o.sh ] && . $bashdir/bp4o.sh

Zsh users, add the following to your ~/.zshrc:

    fpath=( $zshdir \$fpath )
    autoload -Uz bp4o
    bp4o

Fish users, you're ready to go!

EOM
fi
