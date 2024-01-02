# Setup fish
set -l cwd (pwd)
set -x PATH $cwd/test $PATH
set -x fish_function_path $cwd/.fish $fish_function_path
set -x P4ALIASES $cwd
set -x BP4OALIASES $cwd/bp4oaliases

mkdir -p $cwd/.fish
cp $cwd/bp4o.fish $cwd/.fish/p4.fish
