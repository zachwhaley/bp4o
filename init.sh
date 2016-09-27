p4() {
    local cmd=( $@ )

    # Search for and apply aliases from the bp4o aliases file
    local config="${XDG_CONFIG_HOME:=$HOME/.config}/bp4o"
    local alias=$(awk -F= -v cmd="^$cmd *= *" '$0~cmd {print $2}' $config/aliases 2>/dev/null)
    if [ -n  "$alias" ]; then
        cmd=( ${cmd[@]/#$cmd/$alias} )
    fi

    p4bin=$(type -P p4)
    if command which p4-$cmd &>/dev/null; then
        p4-$cmd $p4bin ${cmd[@]}
    else
        $p4bin ${cmd[@]}
    fi
}
