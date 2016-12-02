# Teardown fish
set -l cwd (git rev-parse --show-toplevel)

rm -r $cwd/.fish
