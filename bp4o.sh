p4() {
    if hash p4-$1 2>/dev/null; then
        p4-$1 $(command -v p4) $@
    else
        command p4 $@
    fi
}
