#!/usr/bin/env bash
set -e

if [ "$1" == "-u" ]; then
    nope=1
    shift
fi

if [ $(whoami) == "root" ]; then
    prefix="${1:-/usr/local}"
    bashdir="$prefix/etc/profile.d"
    zshdir="$prefix/share/zsh/site-functions"
    fishdir="$prefix/share/fish/vendor_functions.d"
else
    prefix="${1:-$HOME}"
    bashdir="$prefix/.local/etc/profile.d"
    zshdir="$prefix/.local/share/zsh/functions"
    fishdir="$prefix/.config/fish/functions"
fi

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
cat <<EOM
BP4O Uninstalled!
EOM
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

# Bash 4 expands ~ to the home directory, but Bash 3 doesn't.
# Unfortunately Bash 3 prints '~' literally, while Bash 4 prints only ~
if [ ${BASH_VERSION%%\.[1-9]*} -ge 4 ]; then
    bashdir="${bashdir/#$HOME/'~'}"
    zshdir="${zshdir/#$HOME/'~'}"
    fishdir="${fishdir/#$HOME/'~'}"
else
    bashdir="${bashdir/#$HOME/~}"
    zshdir="${zshdir/#$HOME/~}"
    fishdir="${fishdir/#$HOME/~}"
fi
cat <<EOM

BP4O Installed!

Bash users, add the following to your ~/.bashrc:

  if [ -f $bashdir/bp4o.sh ]; then
    . $bashdir/bp4o.sh
  fi

Zsh users, add the following to your ~/.zshrc:

  fpath=( $zshdir \$fpath )
  autoload -Uz bp4o
  bp4o

Fish users, add this to your ~/.config/fish/config.fish:

  set fish_function_path $fishdir \$fish_function_path

EOM
