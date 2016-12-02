# Setup zsh
local cwd=$(git rev-parse --show-toplevel)
path=($cwd/test $path); export path
fpath=($cwd/.zfunc $fpath); export fpath
export P4ALIASES=$cwd
export BP4OALIASES=$cwd/bp4oaliases

mkdir -p $cwd/.zfunc
cp $cwd/bp4o.zsh $cwd/.zfunc/bp4o

# Load BP4O
autoload -Uz bp4o
bp4o
