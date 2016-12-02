#!/usr/bin/env bash

OFF=$'\033[0;0m'
BOLD=$'\033[0;1m'
RED=$'\033[0;31m'
GREEN=$'\033[0;32m'

cwd=$(git rev-parse --show-toplevel)
P4ALIASES=$cwd
BP4OALIASES=$cwd/bp4oaliases

err=0
testbp4o() {
    local shell=$1
    local cmd="${@:2}"
    if $shell -c "source $cwd/test/setup.$shell; $cmd"; then
        echo "  ${GREEN}Passed!${OFF}"
    else
        err=$((err + 1))
        echo "  ${RED}Failed!${OFF}"
    fi
    if [ -f $cwd/test/teardown.$shell ]; then
        $shell $cwd/test/teardown.$shell
    fi
}
testnormalpath() {
    echo "* Test BP4O normal path"
    testbp4o $1 p4 testbp4o "Normal path"
}
testbp4oaliases() {
    echo "* Test BP4O aliases"
    echo "tb = testbp4o" > $BP4OALIASES
    testbp4o $1 p4 tb "BP4O aliases"
    rm $BP4OALIASES
}
testp4aliases() {
    echo "* Test P4 aliases"
    echo "tb = testbp4o" > $P4ALIASES/.p4aliases
    testbp4o $1 p4 tb "P4 aliases"
    rm $P4ALIASES/.p4aliases
}

for sh in bash zsh fish; do
if command which $sh &>/dev/null; then
echo "
${BOLD}Test ${sh}${OFF}"
    testnormalpath $sh
    testbp4oaliases $sh
    testp4aliases $sh
fi
done

exit $err
