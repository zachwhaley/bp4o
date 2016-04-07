p4() {
    if type p4-$1 1>/dev/null; then
        p4-$1 $(command -v p4) $@
    else
        command p4 $@
    fi
}
