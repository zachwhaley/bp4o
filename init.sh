p4() {
    local opts="$@" cmd="$1"

    # Search for and apply aliases from the bp4o aliases file
    local config="${XDG_CONFIG_HOME:=$HOME/.config}/bp4o"
    local alias=$(sed -n -r "s/$1\s*=\s*(.+)/\1/p" "$config/aliases" 2>/dev/null)
    if [ -n  "$alias" ]; then
        opts="$(echo "$opts" | sed "s/$cmd/$alias/")"
        cmd="$(echo "$opts" | awk '{print $1}')"
    fi

    if type p4-$cmd 1>/dev/null; then
        p4-$cmd $(type -p p4 | awk '{print $3}') $opts
    else
        command p4 $opts
    fi
}
