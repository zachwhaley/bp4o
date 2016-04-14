p4() {
    local cmd=( $@ )

    # Search for and apply aliases from the bp4o aliases file
    local config="${XDG_CONFIG_HOME:=$HOME/.config}/bp4o"
    local alias=$(sed -n -r "s/$cmd\s*=\s*(.+)/\1/p" "$config/aliases" 2>/dev/null)
    if [ -n  "$alias" ]; then
        cmd=( ${cmd[@]/#$cmd/$alias} )
    fi

    p4bin=$(type -P p4)
    if type p4-$cmd &>/dev/null; then
        p4-$cmd $p4bin ${cmd[@]}
    else
        $p4bin ${cmd[@]}
    fi
}
