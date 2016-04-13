p4() {
    if type p4-$1 1>/dev/null; then
        p4-$1 $(type -p p4 | awk '{print $3}') $@
    else
        command p4 $@
    fi
}
