# Bash setup

cwd=$(pwd)
export PATH="$cwd/test:$PATH"
export P4ALIASES=$cwd
export BP4OALIASES=$cwd/bp4oaliases

# Load BP4O
source $cwd/bp4o.bash
